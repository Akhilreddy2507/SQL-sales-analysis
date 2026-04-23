from pathlib import Path
import pandas as pd

BASE_DIR = Path(__file__).resolve().parent
INPUT_PATH = BASE_DIR / "data" / "employees.csv"
OUTPUT_PATH = BASE_DIR / "data" / "employees_cleaned.csv"

def load_data(path: Path) -> pd.DataFrame:
    return pd.read_csv(path)

def run_quality_checks(df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()
    df["hire_date"] = pd.to_datetime(df["hire_date"], errors="coerce")
    df["salary"] = pd.to_numeric(df["salary"], errors="coerce")

    print("Data Quality Report")
    print("-" * 40)
    print(f"Total rows: {len(df)}")
    print(f"Duplicate employee_id rows: {df.duplicated(subset=['employee_id']).sum()}")
    print(f"Missing names: {df['name'].isna().sum()}")
    print(f"Invalid hire dates: {df['hire_date'].isna().sum()}")
    print(f"Invalid or missing salaries: {df['salary'].isna().sum()}")
    print(f"Negative salaries: {(df['salary'] < 0).sum()}")

    df = df.drop_duplicates(subset=["employee_id"])
    df = df.dropna(subset=["name", "hire_date", "salary"])
    df = df[df["salary"] >= 0]
    df["name"] = df["name"].str.title().str.strip()
    df["department"] = df["department"].fillna("Unknown").str.title().str.strip()

    return df

def main() -> None:
    df = load_data(INPUT_PATH)
    cleaned = run_quality_checks(df)
    cleaned.to_csv(OUTPUT_PATH, index=False)
    print("-" * 40)
    print(f"Cleaned file written to: {OUTPUT_PATH}")
    print(f"Rows remaining: {len(cleaned)}")

if __name__ == "__main__":
    main()
