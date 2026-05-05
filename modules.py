import math

class Resource: 
    """ Geo-located resource"""   
    def __init__(self, name, lat, lon):
        self.name = name
        self.lat = lat
        self.lon = lon 



    def distance_to(self, target_lat, target_lon):
        """Haversine formula returning distance in kilometers"""
        R = 6371.0
        lat1, lon1 = math.radians(self.lat), math.radians(self.lon)
        lat2, lon2 = math.radians(target_lat), math.radians(target_lon)
        dlat = lat2 - lat1
        dlon = lon2 - lon1
        a = math.sin(dlat/2)**2 + math.cos(lat1)*math.cos(lat2)*math.sin(dlon/2)**2
        c = 2 * math.atan2(math.sqrt(a), math.sqrt(1-a))
        return R * c

class Patient:
    def __init__(self, name, age, condition_severity):
        self.name = name
        self.age = age
        self.severity = condition_severity # Scale 1 - 5 where 5 is considererd to be critical



class Hospital:
    def __init__(self, name, total_beds, lat, lon):
        self.name = name
        self.total_beds = total_beds
        self.occupied_beds = 0


    def has_space(self):
        return self.occupied_beds < self.total_beds
    
    def allocate_bed(self):
        if self.has_space():
            self.occupied_beds += 1
            return True
        return False
    def discharged(self):
        if self.occupied_beds > 0:
            self.occupied_beds -= 1
            return True
        return False

            
      