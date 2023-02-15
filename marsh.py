from operator import mod
from flask_marshmallow import Marshmallow
from models import *

marsh = Marshmallow()


class VehicleSchema(marsh.Schema):
    class Meta:
        fields=("vehicleId","vehicleSpead","vehicleAge","vehicleName","vehicleModel")
        model = VehicleInfo
