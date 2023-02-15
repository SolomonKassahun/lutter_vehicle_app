from audioop import add
from datetime import date, datetime
from email import message
from email.policy import default
from sqlalchemy import Table, Column, Integer, String, Float, MetaData
import imp
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import DateTime
#from app import db

db = SQLAlchemy()



class VehicleInfo(db.Model):
      __tablename__ = 'reportInfo'
      vehicleId = db.Column(db.Integer, primary_key=True)
      vehicleSpead = db.Column(db.Integer,nullable=False)
      vehicleAge = db.Column(db.Integer,nullable=False)
      vehicleName = db.Column(db.String,nullable=False)
      vehicleModel = db.Column(db.String,nullable=False)
      
