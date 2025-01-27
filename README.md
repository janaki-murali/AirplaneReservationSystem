# Airline Reservation System GUI

This project is a **Graphical User Interface (GUI)** application for an Airline Reservation System. It allows the users to search for flights, view flight details, and book tickets with passenger information. The application is built with **Python** and integrates with a **MySQL database** for backend data management.

---

## Features
- **Flight Search**: Users can search for flights by selecting the origin, destination, and travel date.
- **Flight Results**: Displays available flights in a tabular format, allowing users to select and proceed to booking.
- **Passenger Details**: Collects passenger information, generates a unique ticket number, and confirms bookings.
- **Database Integration**: Uses a MySQL database to store flight, booking, and passenger information.

---

## Project Structure
### Files Included:
1. **`airlinepg1.py`**: Python script for the flight search page.
2. **`airlinepg2.py`**: Python script for the flight results page.
3. **`airlinepg3.py`**: Python script for the passenger details and booking confirmation page.
4. **`database.sql`**: SQL script for creating and initializing the database.

---

## Requirements
### Software:
- Python 3.x
- MySQL Server

### Python Libraries:
- `tkinter` (Standard library for GUI)
- `mysql-connector-python` (For database connectivity)

### Database:
The MySQL database schema and initial data are defined in the `database.sql` file.

---

## How to Run the Project
1. **Set Up the Database**:
   - Import the `database.sql` file into your MySQL server to create and initialize the database.

2. **Install Required Libraries**:
   - Run the following command to install the necessary Python library:
     ```bash
     pip install mysql-connector-python
     ```

3. **Run the Application**:
   - Start the application by running the Python files in sequence:
     1. `airlinepg1.py` - Flight search page.
     2. `airlinepg2.py` - Flight results page.
     3. `airlinepg3.py` - Passenger details and booking confirmation page.

---

## License
This project is licensed under the [MIT License](LICENSE).

---

## Acknowledgments
- Developed as part of a **Database Management Systems (DBMS)** course project.
