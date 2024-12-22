import tkinter as tk
from tkinter import ttk, messagebox
from airlinepg3 import PassengerDetailsPage

class FlightResultsPage(tk.Toplevel):
    def __init__(self, master, search_results,date_of_flying):
        super().__init__(master)
        self.master = master
        self.date_of_flying = date_of_flying 
        self.title("Flight Results")
        self.state('zoomed')
        self.configure(bg="#B9E5E8")

        title_label = tk.Label(self, text="Flight Results", font=("montserrat", 30, "bold"), bg="#B9E5E8", fg="#4A628A")
        title_label.pack(pady=10)

        frame = tk.Frame(self, bg="#B9E5E8")
        frame.pack(pady=20)

        style = ttk.Style()
        style.configure("Custom.Treeview", background="#DFF2EB", fieldbackground="#DFF2EB", foreground="#4A628A", font=("montserrat", 13))
        style.configure("Custom.Treeview.Heading", background="#4A628A", foreground="#4A628A", font=("montserrat", 14, "bold"))
        style.map("Custom.Treeview", background=[("selected", "#7AB2D3")])
        style.layout("Custom.Treeview", [('Treeview.treearea', {'sticky': 'nswe'})])
        style.layout("Custom.Treeview.Heading", [
                    ("Treeview.cell", {"sticky": "nswe"}),
                    ("Treeview.padding", {"sticky": "nswe", "children": [
                    ("Treeview.text", {"sticky": "we"})
                    ]})
                    ])
        self.tree = ttk.Treeview(
            frame, style="Custom.Treeview", columns=("Flight Number", "Departure Time", "Arrival Time", "Available Seats", "Class", "Price"),
            show='headings', height=28
        )

        self.tree.heading("Flight Number", text="Flight Number")
        self.tree.heading("Departure Time", text="Departure Time")
        self.tree.heading("Arrival Time", text="Arrival Time")
        self.tree.heading("Available Seats", text="Available Seats")
        self.tree.heading("Class", text="Class")
        self.tree.heading("Price", text="Price")


        self.tree.column("Flight Number", width=240, anchor='center')
        self.tree.column("Departure Time", width=240, anchor='center')
        self.tree.column("Arrival Time", width=240, anchor='center')
        self.tree.column("Available Seats", width=240, anchor='center')
        self.tree.column("Class", width=240, anchor='center')
        self.tree.column("Price", width=240, anchor='center')

        for flight in search_results:
            self.tree.insert("", tk.END, values=flight)

        self.tree.pack()

        button_frame = tk.Frame(self, bg="#B9E5E8")
        button_frame.pack(fill="x", pady=10, padx=100)

        back_button = tk.Button(button_frame, text="Back", command=self.on_close, font=("montserrat", 15), bg="#4A628A", fg="#DFF2EB", relief="flat")
        back_button.grid(row=0, column=0, sticky="w", padx=(0, 10))

        button_frame.columnconfigure(1, weight=1)

        book_now_button = tk.Button(button_frame, text="Book Now", command=self.book_now, font=("montserrat", 15), bg="#4A628A", fg="#DFF2EB", relief="flat")
        book_now_button.grid(row=0, column=2, sticky="e", padx=(10, 0))

    def on_close(self):
        self.master.deiconify()
        self.master.state('zoomed')
        self.destroy()

    def book_now(self):
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("Selection Error", "Please select a flight to book.")
            return

        selected_flight = self.tree.item(selected_item)['values']
        self.withdraw()

        passenger_page = PassengerDetailsPage(self.master, selected_flight, self.date_of_flying, self)
        passenger_page.grab_set()

    def on_passenger_page_close(self, passenger_page):
        passenger_page.destroy()
        self.deiconify()
        self.state('zoomed')

if __name__ == "__main__":
    sample_results = [
        ("FL123", "10:00 AM", "1:00 PM", "15", "$150"),
        ("FL456", "2:00 PM", "5:00 PM", "20", "$200"),
        ("FL789", "5:00 PM", "8:00 PM", "10", "$180"),
    ]

    root = tk.Tk()
    root.withdraw()
    app = FlightResultsPage(root, sample_results)
    app.mainloop()
