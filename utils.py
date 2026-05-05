def triage_priority(patient):
    # Nested If logic to determine urgency
    if patient.severity >= 4:
        if patient.age > 60 or patient.age < 5:
            return "IMMEDIATE"
        else:
            return "URGENT"
    elif patient.severity >= 2:
        return "STABLE"
    else:
        return "NON-URGENT"


def discharge_patient(hospitals_dict, hospital_name):
    while True:
        hospital_name = input("\n Enter hospital name to discharge from (or 'exit' to quit):")
        if hospital_name.lower() == "exit" :
            break

        target_hospital = hospitals_dict.get(hospital_name.lower())
        if not target_hospital:
            print ( f" ERROR: {hospital_name} not found. Check the name and try again")
            continue
        if target_hospital.discharge():
            print(f"SUCCESS: Bed free at {target_hospital.name}."
                  f"Occupied: {target_hospital.occupied_beds}/{target_hospital.total_beds}")
        else:
            print(f"INFO: No occupied to discharge at {target_hospital.name}.")