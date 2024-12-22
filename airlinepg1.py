
import tkinter as tk
from tkinter import messagebox, ttk
from tkcalendar import DateEntry
import mysql.connector
from datetime import date
from airlinepg2 import FlightResultsPage

def fetch_airports():
    airports = []
    try:
        conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="sandra2301",
            database="airline"
        )
        cursor = conn.cursor()
        cursor.execute("SELECT LOCATION, AIRPORT_CODE FROM AIRPORT")
        airports = [(row[0], row[1]) for row in cursor.fetchall()]
        conn.close()
    except mysql.connector.Error as err:
        messagebox.showerror("Database Error", f"Error: {err}")
    return airports

def search_flights():
    origin_location = combobox_origin.get()
    destination_location = combobox_destination.get()
    date_selected = date_entry.get_date()

    if not (origin_location and destination_location and date_selected):
        messagebox.showwarning("Input Error", "Please fill in all fields")
        return
    date_str = date_selected.strftime('%Y-%m-%d')
    origin_code = get_airport_code(origin_location, airport_list)
    destination_code = get_airport_code(destination_location, airport_list)

    try:
        conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="sandra2301",
            database="airline"
        )
        cursor = conn.cursor()
        cursor.execute(f"""
            CREATE VIEW TIMING AS 
            SELECT FLIGHT_ID, CLASS, DEPARTURE_TIME, ARRIVAL_TIME 
            FROM ROUTE 
            WHERE START_POINT = '{origin_code}' AND END_POINT = '{destination_code}';
        """)

        cursor.execute(f"""
            CREATE VIEW FLIGHTS1 AS 
            SELECT FLIGHT_ID, CLASS, COUNT(*) AS SEATS 
            FROM BOOKING 
            WHERE TICKET_STATUS = 'CONFIRM' AND DATE_OF_FLYING = '{date_str}' 
            GROUP BY FLIGHT_ID, CLASS;
        """)

        cursor.execute("""
            CREATE VIEW FLIGHTS2 AS
            SELECT FLIGHT_ID,CLASS
            FROM FLIGHT
            EXCEPT
            SELECT FLIGHT_ID,CLASS
            FROM FLIGHTS1;
        """)
        cursor.execute("""
            CREATE VIEW FLIGHTS3 AS
            SELECT F.FLIGHT_ID,F.CAPACITY-F1.SEATS AS AVAILABLE_SEATS,F.CLASS,F.PRICE
            FROM FLIGHT F JOIN FLIGHTS1 F1 ON F.FLIGHT_ID=F1.FLIGHT_ID AND F.CLASS=F1.CLASS
            WHERE CAPACITY-SEATS > 0
            UNION
            SELECT F.FLIGHT_ID,F.CAPACITY AS AVAILABLE_SEATS,F.CLASS,F.PRICE
            FROM FLIGHT F JOIN FLIGHTS2 F2 ON F.FLIGHT_ID=F2.FLIGHT_ID AND F.CLASS=F2.CLASS;
        """)

        cursor.execute("""
            SELECT S.FLIGHT_ID,T.DEPARTURE_TIME,T.ARRIVAL_TIME,S.AVAILABLE_SEATS,S.CLASS,S.PRICE
            FROM FLIGHTS3 S JOIN TIMING T ON S.FLIGHT_ID=T.FLIGHT_ID AND S.CLASS=T.CLASS;
        """)

        search_results = cursor.fetchall()

        cursor.execute("DROP VIEW IF EXISTS FLIGHTS3")
        cursor.execute("DROP VIEW IF EXISTS FLIGHTS2")
        cursor.execute("DROP VIEW IF EXISTS FLIGHTS1")
        cursor.execute("DROP VIEW IF EXISTS TIMING")
        conn.close()

        if search_results:
            print("Flights found:", search_results)
            results_page = FlightResultsPage(root, search_results, date_str)
            root.withdraw()
            results_page.protocol("WM_DELETE_WINDOW", lambda: on_closing(results_page))
            results_page.mainloop()
        else:
            messagebox.showinfo("No Flights", "No flights match your criteria.")
    except mysql.connector.Error as err:
        messagebox.showerror("Database Error", f"Error: {err}")

def on_closing(results_page):
    results_page.destroy()
    root.deiconify()
    root.state('zoomed')


def get_airport_code(location, airports):
    for loc, code in airports:
        if loc == location:
            return code
    return None
def create_rounded_rectangle(canvas, x1, y1, x2, y2, radius=25, **kwargs):
    points = [x1+radius, y1, x1+radius, y1, x2-radius, y1, x2-radius, y1,
              x2, y1, x2, y1+radius, x2, y1+radius, x2, y2-radius, x2, y2-radius,
              x2, y2, x2-radius, y2, x2-radius, y2, x1+radius, y2, x1+radius, y2,
              x1, y2, x1, y2-radius, x1, y2-radius, x1, y1+radius, x1, y1+radius, x1, y1]
    return canvas.create_polygon(points, smooth=True, **kwargs)

root = tk.Tk()
root.title("Flight Search")
root.state("zoomed")

root.configure(bg="#B9E5E8")

canvas = tk.Canvas(root, width=600, height=400, bg="#B9E5E8", highlightthickness=0)
rounded_rect = create_rounded_rectangle(canvas, 0, 0, 600, 400, radius=50, fill="#DFF2EB", outline="")
canvas.place(relx=0.5, rely=0.5, anchor="center")

frame = tk.Frame(canvas, bg="#DFF2EB")
canvas.create_window(300, 200, window=frame)

title_label = tk.Label(frame, text="Search for Flights", font=("montserrat", 30,"bold"), bg="#DFF2EB", fg="#4A628A" )
title_label.grid(row=0, column=0, columnspan=2, pady=30)

airport_list = fetch_airports()
airport_locations = [loc for loc, code in airport_list]

tk.Label(frame, text="Origin:", font=("montserrat", 15), bg="#DFF2EB", fg="#4A628A").grid(row=1, column=0, sticky="e", padx=5, pady=5)
combobox_origin = ttk.Combobox(frame, values=airport_locations, font=("montserrat", 12))
combobox_origin.grid(row=1, column=1, padx=5, pady=5)

tk.Label(frame, text="Destination:", font=("montserrat", 15), bg="#DFF2EB", fg="#4A628A").grid(row=2, column=0, sticky="e", padx=5, pady=5)
combobox_destination = ttk.Combobox(frame, values=airport_locations, font=("montserrat", 12))
combobox_destination.grid(row=2, column=1, padx=5, pady=5)

tk.Label(frame, text="Date:", font=("montserrat", 15), bg="#DFF2EB", fg="#4A628A").grid(row=3, column=0, sticky="e", padx=5, pady=5)
date_entry = DateEntry(frame, mindate=date.today(), width=20, background='#4A628A',
                       foreground='#DFF2EB', borderwidth=2, year=date.today().year, font=("montserrat", 12))
date_entry.grid(row=3, column=1, padx=5, pady=5)

search_button = tk.Button(frame, text="Search", command=search_flights, font=("montserrat", 15,"bold"), bg="#4A628A", fg="#DFF2EB", relief="flat")
search_button.grid(row=4, column=0, columnspan=2, pady=30)

root.mainloop()
