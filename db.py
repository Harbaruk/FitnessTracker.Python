import pyodbc

class DBConnection:
    
    @staticmethod
    def NewConnection():
        try:    
            #connection = pyodbc.connect(driver='{SQL Server}', server='(localdb)\\mssqllocaldb', database='FitnessTracker', trusted_connection='yes')
            connection = pyodbc.connect('DRIVER={ODBC Driver 13 for SQL Server};SERVER=(localdb)\mssqllocaldb;Trusted_Connection=yes;DATABASE=FitnessTracker')
            return connection
        except:
            return None
    