import pyodbc
server = '$DB_HOST'
username = '$DB_USERNAME'
password = '$DB_PASSWORD'

cnxn = pyodbc.connect('DRIVER={ODBC Driver 13 for SQL Server};SERVER='+server+';PORT=1443;UID='+username+';PWD='+ password)
cursor = cnxn.cursor()

print ('Using the following SQL Server version:')
tsql = "SELECT @@version;"
with cursor.execute(tsql):
    row = cursor.fetchone()
    print (str(row[0]))