import sqlalchemy
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String

# Create an engine that stores data in the local directory's
# sqlalchemy_example.db file.
engine = create_engine('sqlite:///sqlalchemy_example.db')

# Create all tables in the engine. This is equivalent to "Create Table"
# statements in raw SQL.
Base = sqlalchemy.orm.declarative_base()

class CatFeedingRecord(Base):
    __tablename__ = 'cat_feeding_records'

    id = Column(Integer, primary_key=True)
    date = Column(String)
    time = Column(String)
    amount = Column(Integer)

Base.metadata.create_all(engine)

# Create a connection to the database
def create_connection():
    connection = engine.connect()
    return connection

# Close the connection
def close_connection(connection):
    connection.close()

# Add a new record to the database
def add_record_string(connection, date, time, amount):
    ins = CatFeedingRecord.__table__.insert().values(
        date=date,
        time=time,
        amount=amount
    )
    connection.execute(ins)

# Get all records from the database
def get_records_string(connection):
    records = []
    select_st = CatFeedingRecord.__table__.select()
    result_proxy = connection.execute(select_st)
    for row in result_proxy:
        records.append(row)
    return records

# Delete a record from the database
def delete_record_string(connection, record_id):
    delete_st = CatFeedingRecord.__table__.delete().where(CatFeedingRecord.id==record_id)
    connection.execute(delete_st)

# Delete all records from the database
def delete_all_records_string(connection):
    delete_st = CatFeedingRecord.__table__.delete()
    connection.execute(delete_st)