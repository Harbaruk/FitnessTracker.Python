import pypyodbc

connection = pypyodbc.connect(driver='{SQL Server}', server='(local)\SQLEXPRESS2014', database='WorkIT', uid='sa', pwd='P@ssw0rd')

if (connection):
    cursor = connection.cursor()
    SQLquery = ("""
                SELECT * FROM dbo.test            
    """)
    cursor.execute(SQLquery)
    results = cursor.fetchall()
    print(results)
    connection.close()