import pypyodbc

class DBConnection:
    
    @staticmethod
    def NewConnection():
        try:    
            connection = pypyodbc.connect(driver='{SQL Server}', server='(local)\SQLEXPRESS2014', database='WorkIT', uid='sa', pwd='P@ssw0rd')
            return connection
        except:
            return None
    