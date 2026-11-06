"""
CSV-to-PostgreSQL import template for the airline passenger project.

Before running:
1. Install: py -m pip install pandas sqlalchemy psycopg2-binary
2. Put train.csv in the same folder as this script, or update CSV_PATH.
3. Create the PostgreSQL database and passengers table first.
4. Enter your local PostgreSQL password when prompted.
5. Never publish your password or database credentials.
"""
from pathlib import Path
from getpass import getpass
import pandas as pd
from sqlalchemy import create_engine, text
from sqlalchemy.engine import URL

CSV_PATH = Path(__file__).resolve().parent / "train.csv"
DATABASE = "airline_analysis"
USERNAME = "postgres"
HOST = "localhost"
PORT = 5432
TABLE = "passengers"

# Kaggle CSV headers mapped to the snake_case PostgreSQL table columns.
COLUMN_MAP = {
    "Gender": "gender",
    "Customer Type": "customer_type",
    "Age": "age",
    "Type of Travel": "type_of_travel",
    "Class": "class",
    "Flight Distance": "flight_distance",
    "Inflight wifi service": "inflight_wifi_service",
    "Departure/Arrival time convenient": "departure_arrival_time_convenient",
    "Ease of Online booking": "ease_of_online_booking",
    "Gate location": "gate_location",
    "Food and drink": "food_and_drink",
    "Online boarding": "online_boarding",
    "Seat comfort": "seat_comfort",
    "Inflight entertainment": "inflight_entertainment",
    "On-board service": "on_board_service",
    "Leg room service": "leg_room_service",
    "Baggage handling": "baggage_handling",
    "Checkin service": "checkin_service",
    "Inflight service": "inflight_service",
    "Cleanliness": "cleanliness",
    "Departure Delay in Minutes": "departure_delay_minutes",
    "Arrival Delay in Minutes": "arrival_delay_minutes",
    "satisfaction": "satisfaction",
}

def main():
    if not CSV_PATH.exists():
        raise FileNotFoundError(f"CSV not found: {CSV_PATH}")

    df = pd.read_csv(CSV_PATH)

    # The commonly distributed training CSV includes an 'Unnamed: 0'
    # index-like column and an 'id' column. Drop the index-like column only.
    df = df.loc[:, ~df.columns.astype(str).str.startswith("Unnamed:")]

    if "id" not in df.columns:
        raise ValueError("Expected an 'id' column. Check that you selected the training CSV.")

    df = df.rename(columns=COLUMN_MAP)

    password = getpass("PostgreSQL password: ")
    url = URL.create(
        "postgresql+psycopg2",
        username=USERNAME,
        password=password,
        host=HOST,
        port=PORT,
        database=DATABASE,
    )
    engine = create_engine(url)

    with engine.begin() as connection:
        existing = connection.execute(
            text(f'SELECT COUNT(*) FROM "{TABLE}"')
        ).scalar_one()
        if existing:
            raise RuntimeError(
                f'Table "{TABLE}" already contains {existing} rows. '
                "Stop to avoid importing duplicate records."
            )

    df.to_sql(TABLE, engine, if_exists="append", index=False, chunksize=5000)
    with engine.connect() as connection:
        count = connection.execute(
            text(f'SELECT COUNT(*) FROM "{TABLE}"')
        ).scalar_one()
    print(f"Import complete. Rows in {TABLE}: {count}")

if __name__ == "__main__":
    main()
