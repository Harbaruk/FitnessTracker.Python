from flask import Flask, Blueprint
from flask import request
from flask import jsonify
from flask_cors import CORS
from validate_email import validate_email
from db import DBConnection
import random
import string
import requests

app = Flask(__name__)
CORS(app)

news_controller = Blueprint('news_controller',__name__,url_prefix='/api/news')

app.register_blueprint(news_controller)

@app.route('/api/registration', methods=['POST'])
def api_registration():
    
    print(request.get_json())
    data = request.get_json()
    
    email = data['email']
    is_email_valid = validate_email(email)
    if (is_email_valid == False):
        return jsonify({'status' : 0, 'message': 'Email is not valid!'})
    
    password = data['password']
    
    if (len(password) < 8):
        return jsonify({'status' : 0, 'message': 'Password is too short'})
    
    connection = DBConnection.NewConnection()
    if (connection == None):
        response = jsonify({'status' : 0, 'message': 'Unable to connect to the database'})
        return response
    sql = """\
    EXEC [dbo].[uspCreateNewUser]  @email=?,
                            	@password=?,
                            	@firstname=?,
                            	@lastname=?,
                            	@role=?,
                                @age=?,
                                @height=?,
                                @sex=?,
                                @weight=?
    """
    userType = ((0, 1)[ data['userType'] == "User" ])
    params = (data['email'], data['password'], data['firstname'], data['lastname'],0, data['age'], data['height'], data['sex'], data['weight'])
    cursor = connection.cursor()
    cursor.execute(sql, params)
    result = cursor.fetchall()
    cursor.commit()
    status = result[0][0]
    cursor.close()
    del cursor
    
    connection.close()
    
    
    if (status == 0):
        response = jsonify({'status' : 0, 'message': 'This email has already been registered!'})
        return response
    
    response = jsonify({'status' : 1, 'message' : 'You have been successfully registered!'})
    return response

def generate_token():
    return ''.join(random.SystemRandom().choice(string.ascii_uppercase + string.digits) for _ in range(32))

class Auth:
    @staticmethod
    @app.route('/api/user/checkAuth/<id>', methods = ['POST'])
    def checkAuth():
         data = request.get_json()
         userId = 0;
         if ('userId' in data):
             userId = data['userId']
             
         token = "";
         if ('token' in data):
             token = data['token']
             
         connection = DBConnection.NewConnection()  
         if (connection == None):
             response = jsonify({'status' : 0, 'message': 'Unable to connect to the database'})
             return response
         sql = """\
         EXEC [dbo].[CheckAuth]  @UserId=?,
                                 @Token=?
         """
         
         params = (userId, token)
         cursor = connection.cursor()
         cursor.execute(sql, params)
         result = cursor.fetchall()
         cursor.commit()
         cursor.close()
         connection.close()
         
         status = result[0][0]
         userType = result[0][1]
         return jsonify({'status': status, 'userType': userType});
    
    @staticmethod
    @app.route('/api/user/Auth/', methods = ['POST'])
    def Auth():
        data  = request.get_json()
        email = ""
        if ('email' in data):
            email = data['email']
            
        password = ""
        if ('password' in data):
            password = data['password']
        
        connection = DBConnection.NewConnection()  
        if (connection == None):
            response = jsonify({'status' : 0, 'message': 'Unable to connect to the database'})
            return response
        sql = """\
        EXEC [dbo].[UserAuthorization]  @Email=?,
                                         @Password=?,
                                         @inToken=?
        """
         
        params = (email, password, generate_token())
        cursor = connection.cursor()
        cursor.execute(sql, params)
        result = cursor.fetchall()
        cursor.commit()
         
        userId = result[0][0]
        outToken = result[0][1]
         
        if (userId == 0):
            response = jsonify({'status' : 0, 'message': 'Incorrect email or password'})
            return response
        
        response = jsonify({'status' : 1, 'userId' : userId, 'token': outToken})
        return response
    
class User:
    @staticmethod
    @app.route('/api/user/<int:id>', methods = ['POST'])
    def UserInfo(id):
        data = request.get_json()
        userId = 0
        if ('userId' in data):
            userId = data['userId']
        connection = DBConnection.NewConnection()  
        if (connection == None):
            response = jsonify({'status' : 0, 'message': 'Unable to connect to the database'})
            return response
        sql = """\
        EXEC [dbo].[GetUserInfo]  @userId=?
                                  @token=?
        """
         
        params = [userId, data['token']]
        cursor = connection.cursor()
        cursor.execute(sql, params)
        result = cursor.fetchall()
        cursor.commit()
        cursor.close()
        connection.close()
        firstname = ""
        lastname = ""
        age = ""
        email = ""
        height = ""
        weight = ""
        userType = None
        status = 1
        message = ""
        
        if (result):
            firstname = result[0][0]
            lastname = result[0][1]
            age = result[0][2]
            email = result[0][3]
            image = result[0][4]
            userType = result[0][5]
            height = result[0][6]
            weight = result[0][7]
            status = 1
        
        if (userType == None):
            status = 0
            message = "User not found"
        
        response = jsonify({'status' : status, 'message': message, 'firstname' : firstname, 'lastname' : lastname, 'age':age, 'email' : email, 'userType' : userType, 'weight':weight, 'height':height, 'image':image})
        return response
        
    @staticmethod
    @app.route('/api/user', methods=['PUT'])
    def UpdateUser():
        data = request.get_json()
        connection = DBConnection.NewConnection()  
        if (connection == None):
            response = jsonify({'status' : 0, 'message': 'Unable to connect to the database'})
            return response
        sql = """\
        EXEC [dbo].[UpdateUser]  @firstname=?
                                 @lastname=?
                                 @email=?
                                 @sex=?
                                 @height=?
                                 @weight=?
                                 @age=?
                                 @token=?
        """
         
        params = [data['firstname'],data['lastname'],data['email'],data['sex'],data['height'],data['weight'], data['age'],data['toke']]
        cursor = connection.cursor()
        cursor.execute(sql, params)
        result = cursor.fetchall()
        cursor.commit()
        cursor.close()
        connection.close()

class Plan:
    @staticmethod
    @app.route('/api/user/plan/get',methods=['POST'])
    def GetPlan():
        data = request.get_json()
        connection = DBConnection.NewConnection()
        sql = """\
         EXEC [dbo].[GetPlans]       @token=?
         """
         
        params = [data['token']]
        cursor = connection.cursor()
        cursor.execute(sql, params)
        result = cursor.fetchall()
        cursor.commit()
        cursor.close()
        connection.close()

        data = []

        for row in result:
             currentRow = {
                 'duration':row[2],
                 'name':row[1],
                 'id':row[0]}
             data.append(currentRow)
        
        response = jsonify({'status' : 1, 'plans': data})
        return response

    @staticmethod
    @app.route('/api/user/plan/<int:id>', methods = ['PUT'])
    def UpdatePlan(id):
        data = request.get_json()
        connection = DBConnection.NewConnection()
        sql = """\
         EXEC [dbo].[UpdatePlan]    @postId=?
                                    @duration=?
                                    @name=?
                                    @token=?
         """
         
        params = [data['postId'],data['duration'],data['name'], data['token']]
        cursor = connection.cursor()
        cursor.execute(sql, params)
        result = cursor.fetchall()
        cursor.commit()
        status = result[0][0]
        cursor.close()
        connection.close()
        
        if (status == 0):
            response = jsonify({'status' : 0, 'message': 'Access denied'})
            return response
        
        response = jsonify({'status' : 1, 'message': 'Resume was successfully added'})
        return response
        
    @staticmethod
    @app.route('/api/user/plan/<int:id>/<token>',methods=['DELETE'])
    def DeletePlan(id, token):
        connection = DBConnection.NewConnection()
        sql = """\
        EXEC [dbo].[DeletePlan]    @id=?
                                    @token=?
        """
        params = [id, token]
        cursor = connection.cursor()
        cursor.execute(sql, params)
        result = cursor.fetchall()
        cursor.commit()
        status = result[0][0]
        cursor.close()
        connection.close()
        
        if (status == 0):
            response = jsonify({'status' : 0, 'message': 'Access denied'})
            return response
        
        response = jsonify({'status' : 1, 'message': 'Resume was successfully added'})
        return response
   
class Block:
    @staticmethod
    @app.route('/api/user/block/<int:id>', methods = ['POST'])
    def getFullPlanInfo(id):
         data = request.get_json()
         planId = id
         print(postId)
         connection = DBConnection.NewConnection()  
         if (connection == None):
             response = jsonify({'status' : 0, 'message': 'Unable to connect to the database'})
             return response
        
         sql = """\
         EXEC [dbo].[GetBlocks]    @id=?
                                   @token=?
         """
         
         params = [planId, data['token']]
         cursor = connection.cursor()
         cursor.execute(sql, params)
         result = cursor.fetchall()
         cursor.commit()
         cursor.close()
         connection.close()
        
         data = []
         for row in result:
             currentRow = {
                 'name': row[1],
                 'id': row[0]}
             data.append(currentRow)
             
         if (not data):
             response = jsonify({'status' : 0, 'message': 'There is not plan with current id'})
             return response
         
         response = jsonify({'status' : 1, 'data': data})
         return response

    @staticmethod
    @app.route('/api/user/block',methods=['PUT'])
    def UpdateBlock():
        data = request.get_json()
        connection = DBConnection.NewConnection()

        sql = """\
        EXEC [dbo].[UpdateBlocks]    @id=?
                                      @name=?
                                      @token=?
        """
         
        params = [planId,data['name'], data['token']]
        cursor = connection.cursor()
        cursor.execute(sql, params)
        result = cursor.fetchall()
        cursor.commit()
        cursor.close()
        connection.close()

    @staticmethod
    @app.route('/api/user/block/<int:id>/<token>', methods = ['DELETE'])
    def DeleteBlock():
        connection = DBConnection.NewConnection()
        data = request.get_json()

        sql = """\
         EXEC [dbo].[DeleteBlocks]    @id=?
                                      @token=?
         """
         
        params = [id, token]
        cursor = connection.cursor()
        cursor.execute(sql, params)
        result = cursor.fetchall()
        cursor.commit()
        cursor.close()
        connection.close()

class Exercise:
    @staticmethod
    @app.route('/api/block/<id>/exercises/<token>', methods=['GET'])
    def GetExercises(id,token):
        connection = DBConnection.NewConnection()

        sql = """\
         EXEC [dbo].[GetExercises]    @id=?
                                    @token=?
         """
         
        params = [id, token]
        cursor = connection.cursor()
        cursor.execute(sql, params)
        result = cursor.fetchall()
        cursor.commit()
        cursor.close()
        connection.close()

        data = []

        for row in result:
             currentRow = {
                 'distance':row[5],
                 'type':row[4],
                 'weight':row[3],
                 'createdAt':row[2],
                 'amount': row[1],
                 'id': row[0]}
             data.append(currentRow)
        
        response = jsonify({'status' : 1, 'exercises': data})
        return response

    @staticmethod
    @app.route('/api/exercise/<id>',methods=['PUT'])
    def UpdateExercise(id):
        data = request.get_json()
        connection = DBConnection.NewConnection()

        sql = """\
         EXEC [dbo].[UpdateExercise]    @id=?
                                        @token=?
                                        @distance=?
                                        @type=?
                                        @weight=?
                                        @createdAt=?
                                        @amount=?
         """
         
        params = [id, data['token'],data['distance'],data['type'],data['weight'],data['createdAt'],data['amount']]
        cursor = connection.cursor()
        cursor.execute(sql, params)
        result = cursor.fetchall()
        cursor.commit()
        cursor.close()
        connection.close()

    @staticmethod
    @app.route('/api/exercise/<id>/<token>', methods=['DELETE'])
    def DeleteExercise(id,token):
        connection = DBConnection.NewConnection()

        sql = """\
         EXEC [dbo].[DeleteExercise]    @id=?
                                        @token=?
         """
         
        params = [id, token]
        cursor = connection.cursor()
        cursor.execute(sql, params)
        result = cursor.fetchall()
        cursor.commit()
        cursor.close()
        connection.close()

# class News:
#     @staticmethod
#     @app.route('/', methods=['GET'])
#     def GetNews():
        # apiUrl = 'https://newsapi.org/v2/everything?sources=nfl-news&sortBy=popularitylanguage=en&apiKey=5cf0ee4070bc4d38ab89ea05bec9935a'
        # return requests.get(apiUrl).content

if __name__ == "__main__":
    app.run()
    
