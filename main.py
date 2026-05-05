from modules import Patient, Hospital
from dispatch import Dispatch
from utils import discharge_patient

#Accra region hospitals with real coordinates (lat, lon) and your bed capacities
hospitals_dict = {
    "Korle-bu": Hospital ("Korle-Bu", 2000, 5.5378, -0.2280),
    "37 military": Hospital ("37 Military", 3000, 5.5917, -0.1850),
    "tema general": Hospital ("Tema General", 2000, 5.56380, -0.0106),
    "lekma hospital": Hospital ("Lekma Hospital", 1000, 5.5950, -0.1123),
    "ridge hospital": Hospital ("Ridge Hospital", 1000, 5.5627, -00.2011),
    "university of ghana medical center": Hospital ("University of Ghana Medical Center", 1000, 5.6510, -0.1910),
    "trust hospital": Hospital ("Trust hospital", 1000, 5.5744, -0.1899)
}

#Create the Dispatch instance (composition)
dispatch = Dispatch(hospitals_dict)

def run_system():
    print("---Emergency Bed Referral System (with Nearest Hospital)---")
    while True:
        user_input = input("\nEnter Patient Name (or 'exit', or 'discharge', or 'update'):").strip().lower()

        if user_input == 'exit' :
            break


        #Handle discharge request
        elif user_input == 'discharge':
            hospital_name = input("Enter Hospital Name to discharge from:").strip().lower()
            discharge_patient(hospitals_dict, hospital_name)
            continue


        # Handle bed count update via dispatch
        elif user_input == 'update':
            hospital_name = input("Enter Hospital Name to update: ").strip().lower()
            new_occupied = int(input("Enter new occupied beds count: "))
            dispatch.update_bed_count(hospital_name, new_occupied)
            continue

        #Otherwise, treat input as patient name
        else: 
            name = user_input
            age = int(input("Enter Age:  "))
            severity = int(input("Enter Severity (1-5): "))
            lat = float(input("Enter Patient Latitude: "))
            lon = float(input("Enter Patient Longitude: "))

            patient = patient(name,age,severity)
            dispatch.dispatch_patient(patient, lat, lon)


if __name__ == "__main__":
     run_system()



