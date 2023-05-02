import os
import database
import time

# Create a database connection
conn = database.create_connection()

print("")
print("                      CatEats Application")
print(r"""                                                                                                       
                         /\     /\                                                
                        {  `---'  }                                                
                        {  O   O  }                                                
                        ~~>  V  <~~                                                
                         \  \|/  /                                                 
                          `-----'____                                              
                          /     \    \_                                            
                         {       }\  )_\_   _                                      
                         |  \_/  |/ /  \_\_/ )                                     
                          \__/  /(_/     \__/                                      
                            (__/                                                   
                    """)
print("\nWelcome to your cat's meal recorder!")
print("Made by James Adelhelm (Personal Project) & Tamarsh Abeysekera (Microservice)")


#main part of program
while True:
    print("")
    print("Input one of the following commands:")
    print("\n1. Add new record")
    print("2. View records")
    print("3. Delete a record")
    print("4. Delete ALL records and CLEAR database")
    print("5. Learn a Cat Fact from Tamarsh's Microservice")
    print("6. Quit application")

    command = input("\nEnter command: ")

    if command == "1":
        # Add a new record
        print("")
        print("You are now entering a new record.")
        print("")
        record_date = input("Enter date: ")
        record_time = input("Enter time: ")
        record_amount = input("Enter amount: ")

        database.add_record_string(conn, record_date, record_time, record_amount)
        print("Successfully added record!")
        user_decision = input("Would you like to learn a cat fact? Enter 1 for YES or 2 for No:")
        if user_decision == "1":
            with open(
                    "/Users/jamesadelhelm/Documents/Work/OSU/Winter 2023 Classes/CS 361 Software Engineering I/cs361_project_teamwork/cat_facts/comms.txt",
                    "w") as file:
                file.write("fact")
            time.sleep(3)
            with open(
                    "/Users/jamesadelhelm/Documents/Work/OSU/Winter 2023 Classes/CS 361 Software Engineering I/cs361_project_teamwork/cat_facts/comms.txt") as file:
                cat_fact = file.readline()
            print(cat_fact)

    elif command == "2":
        # View all records
        records = database.get_records_string(conn)
        print("")
        print("    YOUR CAT'S FEEDING HISTORY")
        print("Record Number | Date | Time | Amount")
        print("---------------------------------------")
        for record in records:
            print(record)
    elif command == "3":
        # Delete a record
        record_id = input("Enter record number: ")
        delete_choice = input(f"Are you sure you want to delete record number: {record_id}? Enter the record number again to confirm: ")
        if delete_choice == record_id:
            database.delete_record_string(conn, record_id)
            print("Record deleted.")
        else:
            print(f"Record {record_id} has not been deleted.")

    elif command == "4":
        delete_decision = input("Are you sure you want to delete all records? Enter 1 for YES or 2 for NO: ")
        if delete_decision == "1":
            database.delete_all_records_string(conn)
            print("All records deleted.")
        else:
            print("No records have been deleted.")

    elif command == "5":
        with open("/Users/jamesadelhelm/Documents/Work/OSU/Winter 2023 Classes/CS 361 Software Engineering I/cs361_project_teamwork/cat_facts/comms.txt", "w") as file:
            file.write("fact")
        time.sleep(3)
        with open("/Users/jamesadelhelm/Documents/Work/OSU/Winter 2023 Classes/CS 361 Software Engineering I/cs361_project_teamwork/cat_facts/comms.txt") as file:
            cat_fact = file.readline()
        print(cat_fact)

    elif command == "6":
        # Quit program
        confirm_quit = input("Are you sure you want to quit? Enter 6 again to confirm or any other key to go back: ")
        if confirm_quit == "6":
            print(r"""                               
                  db         db                                      
                 dpqb       dp8b                                     
                 8b qb_____dp_88                                     
                 88/ .        `p                                     
                 q'.            \                                    
                .'.  .-.    ,-.  `--.                                
                |.  / 0 \  / 0 \ |   \                               
                |.  `.__   ___.' | \\/                               
                |.       "       | (                                 
                 \.    `-'-'    ,' |                                 
                _/`------------'. .|                                 
               /.  \\::(::[];)||.. \                                 
              /.  ' \.`:;;;;'''/`. .|                                
             |.   |/ `;--._.__/  |..|                                
             |.  _/_,'''',,`.    `:.'                                
             |.     ` / ,  ',`.   |/                                 
              \.   -'/\/     ',\  |\                                 
               /\__-' /\ /     ,. |.\                                
              /. .|  '  /-.    ,: |..\                               
             :.  .|    /| | ,  ,||. ..:                              
             |.  .`     | '//` ,:|.  .|                              
             |..  .\      //\/ ,|.  ..|                              
              \.   .\     <./  ,'. ../                               
               \_ ,..`.__    _,..,._/                                
                 `\|||/  `--'\|||/'                                  
                                         """)
            print("Goodbye.")
            break
    else:
        print("Returning to main menu.")

database.close_connection(conn)
os.system("pause")
