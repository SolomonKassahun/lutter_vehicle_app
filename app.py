
from flask import Flask ,render_template, url_for, flash, redirect, request, jsonify
from flask_marshmallow import Marshmallow
from flask_restplus import Resource,Api,fields,Namespace, namespace
from sqlalchemy import Table, Column, Integer, String, Float, MetaData, null
from sqlalchemy import true
from werkzeug.utils import cached_property
from flask_cors import CORS
from datetime import datetime
#from flask_jwt_extended import JWTManager, jwt_required, create_access_token





from setting import *
from models import *
from marsh import *

app = Flask(__name__)
app.config['JWT_SECRET_KEY'] = "Alaways Store Hashed Value"
app.config['SQLALCHEMY_DATABASE_URI'] = SQLALCHEMY_DATABASE_URI
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = SQLALCHEMY_TRACK_MODIFICATIONS
CORS(app,resources={"/api/*": {"origins": "*"}})
app.config['CORS_HEADERS'] = 'Content-Type'
app.config['content-Type'] =  'application/json'


db.init_app(app) # initialize
with app.app_context():
  db.create_all()

marsh = Marshmallow(app)



vehicle_schema = VehicleSchema()
vehicles_schema = VehicleSchema(many = true)

api = Api(app,version="1",title="App Database",description="Flutter Assignment")
list_of_names = {}


Vehicle = api.model("VehicleInfo",{
    'vehicleId': fields.String("vehicleId"),
     'vehicleSpead':fields.String("vehicleSpead"),
    'vehicleAge':fields.String("vehicleAge"),
    'vehicleName':fields.String("vehicleName"),
     'vehicleModel':fields.String("vehicleModel"),
   
    
}

)

@api.route("/api/VehicleInfo")
class VehicleResource(Resource):
    def get(self):
        vehicle = VehicleInfo.query.all()
        return vehicles_schema.dump(vehicle)
    
    @api.expect(Vehicle)
    @api.response(201,"Successfuly created new Vehicle!")
    def post(self):
        vehicle = VehicleInfo()
        vehicle.vehicleId = request.json['vehicleId']
        vehicle.vehicleSpead = request.json['vehicleSpead']
        vehicle.vehicleAge = request.json['vehicleAge']
        vehicle.vehicleName = request.json['vehicleName']
        vehicle.vehicleModel = request.json['vehicleModel']
        db.session.add(vehicle)
        db.session.commit()
       
        return vehicle_schema.dump(vehicle), 201
    @api.response(204, 'vehicle deleted.')
    def delete(self, id):
        vehicle = VehicleInfo.query.filter_by(vehicleId = id).first()
        if vehicle is None:
            return None, 404
        db.session.delete(vehicle)
        db.session.commit()
        return None, 204


