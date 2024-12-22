import tkinter as tk
from tkinter import messagebox
import mysql.connector
from datetime import datetime

class PassengerDetailsPage(tk.Toplevel):
    def __init__(self, master, selected_flight, date_of_flying, previous_page):
        super().__init__(master)
        self.master = master
        self.date_of_flying = date_of_flying
        self.previous_page = previous_page
        self.title("Passenger Details")
        self.state("zoomed")
        self.configure(bg="#B9E5E8")

        self.selected_flight = selected_flight
        title_label = tk.Label(self, text="Enter Passenger Details", font=("montserrat", 30, "bold"), bg="#B9E5E8", fg="#4A628A")
        title_label.pack(pady=10) 

        canvas = tk.Canvas(self, width=600, height=400, bg="#B9E5E8", highlightthickness=0)
        canvas.pack(pady=(50, 20), expand=True)

        rounded_rect = self.create_rounded_rectangle(canvas, 0, 0, 600, 400, radius=50, fill="#DFF2EB", outline="")
        
        frame = tk.Frame(canvas, bg="#DFF2EB")
        canvas.create_window(300, 200, window=frame)

        self.fields = [
            ("Name:", tk.StringVar()),
            ("Passport Number:", tk.StringVar()),
            ("Email ID:", tk.StringVar()),
            ("Address:", tk.StringVar()),
            ("Phone Number:", tk.StringVar()),
            ("Age:", tk.StringVar()),
        ]

        for i, (label_text, variable) in enumerate(self.fields):
            label = tk.Label(frame, text=label_text, font=("montserrat", 15), bg="#DFF2EB", fg="#4A628A")
            label.grid(row=i, column=0, pady=5, padx=10, sticky="e")
            entry = tk.Entry(frame, textvariable=variable, font=("montserrat", 12), relief="flat")
            entry.grid(row=i, column=1, pady=5, padx=10)

        button_frame = tk.Frame(self, bg="#B9E5E8")
        button_frame.pack(fill="x", pady=(10, 50), padx=100)

        back_button = tk.Button(button_frame, text="Back", command=self.on_back, font=("montserrat", 15), bg="#4A628A", fg="#DFF2EB", relief="flat")
        back_button.grid(row=0, column=0, sticky="w", padx=(0, 10))

        button_frame.columnconfigure(1, weight=1)

        confirm_button = tk.Button(button_frame, text="Confirm Booking", command=lambda: self.confirm_booking(*[var.get() for _, var in self.fields]), font=("montserrat", 15), bg="#4A628A", fg="#DFF2EB", relief="flat")
        confirm_button.grid(row=0, column=2, sticky="e", padx=(10, 0))

        add_passenger_button = tk.Button(button_frame, text="Add Passenger", command=lambda: self.add_passenger(*[var.get() for _, var in self.fields]), font=("montserrat", 15), bg="#4A628A", fg="#DFF2EB", relief="flat")
        add_passenger_button.grid(row=0, column=1, padx=(10, 10))

        self.protocol("WM_DELETE_WINDOW", self.on_back)

    def on_back(self):
        self.previous_page.deiconify()
        self.previous_page.state('zoomed')
        self.destroy()
    def generate_passenger_id(self):
        conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="sandra2301",
            database="airline"
        )
        cursor = conn.cursor()
        cursor.execute("SELECT MAX(PASSENGER_ID) FROM PASSENGER WHERE PASSENGER_ID LIKE 'P%'")
        last_id = cursor.fetchone()[0]
        conn.close()

        if last_id:
            new_id = int(last_id[1:]) + 1
            return f"P{new_id:03}"
        else:
            return "P001"
        
    def generate_ticket_number(self):
        conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="sandra2301",
            database="airline"
        )
        cursor = conn.cursor()
        cursor.execute("SELECT MAX(TICKET_NUMBER) FROM BOOKING")
        last_ticket = cursor.fetchone()[0]
        conn.close()

        return 1001 if last_ticket is None else last_ticket + 1

    def confirm_booking(self, name, passport, email, address, phone, age):
        flight_number = self.selected_flight[0]

        if not all([name, passport, email, address, phone, age]):
            messagebox.showwarning("Input Error", "Please enter all details.")
            return
        if not phone.isdigit():
            messagebox.showwarning("Input Error", "Phone Number must be numeric.")
            return

        if not age.isdigit():
            messagebox.showwarning("Input Error", "Age must be numeric.")
            return

        try:
            conn = mysql.connector.connect(
                host="localhost",
                user="root",
                password="sandra2301",
                database="airline"
            )
            cursor = conn.cursor()
            passenger_id = self.generate_passenger_id()
            ticket_number = self.generate_ticket_number()
            date_of_flying = self.date_of_flying
        
            cursor.execute("INSERT INTO PASSENGER (PASSENGER_ID, P_NAME, PASSPORT_NUMBER, EMAIL, ADDRESS, PHONE_NUMBER, AGE) VALUES (%s, %s, %s, %s, %s, %s, %s)",
                        (passenger_id, name, passport, email, address, phone, age))

            cursor.execute("INSERT INTO BOOKING (TICKET_NUMBER, FLIGHT_ID, PASSENGER_ID, DATE_OF_FLYING, CLASS, PAYMENT_MODE, TICKET_STATUS) VALUES (%s, %s, %s, %s, %s, %s, %s)",
                        (ticket_number, flight_number, passenger_id, date_of_flying, self.selected_flight[4], 'ONLINE', 'CONFIRM'))

            conn.commit()
            conn.close()

            messagebox.showinfo("Booking Confirmed", f"Booking for {name} confirmed! Your Ticket Number is {ticket_number}.")
            self.destroy()
            self.master.deiconify()
            self.master.state('zoomed')

        except mysql.connector.Error as err:
            messagebox.showerror("Database Error", f"Error: {err}")

    def add_passenger(self, name, passport, email, address, phone, age):
        flight_number = self.selected_flight[0]
        if not all([name, passport, email, address, phone, age]):
            messagebox.showwarning("Input Error", "Please enter all details.")
            return
        if not phone.isdigit():
            messagebox.showwarning("Input Error", "Phone Number must be numeric.")
            return

        if not age.isdigit():
            messagebox.showwarning("Input Error", "Age must be numeric.")
            return
        try:
            conn = mysql.connector.connect(
                host="localhost",
                user="root",
                password="sandra2301",
                database="airline"
            )
            cursor = conn.cursor()

            passenger_id = self.generate_passenger_id()
            ticket_number = self.generate_ticket_number()
        
            date_of_flying = self.date_of_flying
            cursor.execute("INSERT INTO PASSENGER (PASSENGER_ID, P_NAME, PASSPORT_NUMBER, EMAIL, ADDRESS, PHONE_NUMBER, AGE) VALUES (%s, %s, %s, %s, %s, %s, %s)",
                           (passenger_id, name, passport, email, address, phone, age))

            cursor.execute("INSERT INTO BOOKING (TICKET_NUMBER, FLIGHT_ID, PASSENGER_ID, DATE_OF_FLYING, CLASS, PAYMENT_MODE, TICKET_STATUS) VALUES (%s, %s, %s, %s, %s, %s, %s)",
                           (ticket_number, flight_number, passenger_id, date_of_flying, self.selected_flight[4], 'ONLINE', 'CONFIRM'))

            conn.commit()

            for _, variable in self.fields:
                variable.set("")

            messagebox.showinfo("Passenger Added", f"Booking for {name} confirmed! Your Ticket Number is {ticket_number}.")
        
            conn.close()

        except mysql.connector.Error as err:
            messagebox.showerror("Database Error", f"Error: {err}")


    def create_rounded_rectangle(self, canvas, x1, y1, x2, y2, radius=25, **kwargs):
        points = [x1 + radius, y1, x1 + radius, y1, x2 - radius, y1, x2 - radius, y1,
                  x2, y1, x2, y1 + radius, x2, y1 + radius, x2, y2 - radius, x2, y2 - radius,
                  x2, y2, x2 - radius, y2, x2 - radius, y2, x1 + radius, y2, x1 + radius, y2,
                  x1, y2, x1, y2 - radius, x1, y2 - radius, x1, y1 + radius, x1, y1 + radius, x1, y1]
        return canvas.create_polygon(points, smooth=True, **kwargs)
