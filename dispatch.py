class Dispatch:
    """
    Dispatch class that can: 1. Update bed count 2. Find the nearest hospital with at least one available bed."""
    
    def __init__(self, hospitals_dict):
      self.hospitals = hospitals_dict
    
    def update_bed_count(self, hospitals_name , new_occupied):
        key = hospitals_name.lower()
        if key in self.hospitals:
            hosp = self.hospitals[key]
            if 0 <= new_occupied <= hosp.total_beds:
                hosp.occupied_beds = new_occupied
                print(f"Updated {hosp.name}: {hosp.occupied_beds}/ {hosp.total_beds} occupied.")
            else:
                    print ( "Invalid occupied count") 
        else:
                print(f"Hospital  '{hospitals_name}' not found in network.") 

    def find_nearest( self, patient_lat, patient_lon):
        """
        Return the hospital with a free bed that is geopgraphically closest. If none have space, return None"""   
        nearest = None 
        min_dist = float ('inf')    
        for hospital in self.hospitals.values():
            if hospital.has_space(): 
                 dist = hospital.distance_to(patient_lat, patient_lon) 
                 if dist < min_dist:
                      min_dist = dist
                      nearest = hospital
        return nearest

    def dispatch_patient( self, patient,  patient_lat, patient_lon):
         
         """ Full workflow: triage, find nearest available, allocate_bed"""  
         from utils import triage_priority
         priority = triage_priority(patient)
         print(f"Triage Result: {priority} PRIORITY")

         hospital = self.find_nearest(patient_lat, patient_lon)
         if hospital:
              if hospital.allocate_bed():
                   dist = hospital.distance_to(patient_lat, patient_lon)
                   print(f"SUCCESS: Bed assigned at {hospital.name} ({dist:.1f} km away)")
              else:
                   print ("CRITICAL: Bed allocation failed")
         else:
              print("Alert :NO BEDS AVALIABLE in the network! Initiate emergency protocols.")               

                     

