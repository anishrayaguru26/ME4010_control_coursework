import pandas as pd

# Extracted data from the image
data = [
    # Date, Description, Amount (in Rs.)
    ("13/07/2025", "DSI NEXUS KORAMANGALA 2BANGALORE", 499.00),
    ("13/07/2025", "MANDYA ORGANIC FOODS PVBANGALORE", 1294.00),
    ("15/07/2025", "HITESH MEDICAL Bangalore", 608.00),
    ("16/07/2025", "AMAZON PAY INDIA PRIVA Bangalore", 804.00),
    ("16/07/2025", "CULT BENGALURU", 369.00),
    ("16/07/2025", "CULT BENGALURU (Credit)", -369.00),
    ("17/07/2025", "TOP IN TOWN HYPERMARK BANGALORE", 451.00),
    ("17/07/2025", "MANDYA ORGANIC FOODS PVBANGALORE", 443.00),
    ("20/07/2025", "AMAZON PAY INDIA PRIVA Bangalore", 689.00),
    ("20/07/2025", "MANDYA ORGANIC FOODS PVBANGALORE", 1900.00),
    ("20/07/2025", "PVR INOX LIMITED BANGALORE", 1450.00),
    ("21/07/2025", "MANDYA ORGANIC FOODS PVBANGALORE", 216.00),
    ("23/07/2025", "INDIAN INSTITUTE OF TECH", 112152.00),
    ("24/07/2025", "MANDYA ORGANIC FOODS P Bangalore", 854.00),
    ("24/07/2025", "AMAZON PAY INDIA PRIVA www.amazon.i", 1076.05),
    ("24/07/2025", "AMAZON PAY INDIA PRIVA www.amazon.i", 472.76),
    ("25/07/2025", "MANDYA ORGANIC FOODS P Bangalore", 1809.00),
    ("25/07/2025", "AMAZON PAY INDIA PRIVA Bangalore", 374.00),
    ("25/07/2025", "AMAZON PAY INDIA PRIVA Bangalore", 183.00),
    ("27/07/2025", "CINEPOLIS BSR CHENNAI", 190.00),
    ("28/07/2025", "AMAZON PAY INDIA PRIVA www.amazon.i", 1267.55),
    ("31/07/2025", "PPSL'Jubilant Foodwork Noida", 711.00),
    ("02/08/2025", "AMAZON PAY INDIA Pvt L Bangalore", 275.75),
    ("08/08/2025", "MY FASHION Bangalore", 1198.00),
    ("08/08/2025", "MANDYA ORGANIC FOODS P Bangalore", 1021.00),
    ("08/08/2025", "SOWPARNIKA RETAIL PRD BANGALORE", 328.00),
    ("09/08/2025", "DECATHLON SPORTS INDIA BANGALORE", 1198.00),
    ("09/08/2025", "TOP IN TOWN HYPERMARK BANGALORE", 210.00),
    ("09/08/2025", "MANDYA ORGANIC FOODS P Bangalore", 606.00),
    ("11/08/2025", "AMAZON PAY INDIA PRIVA Bangalore", 2004.00),
]

# Create dataframe
df = pd.DataFrame(data, columns=["Date", "Description", "Amount (Rs.)"])

# Group by transaction type (simplified categorization based on keywords)
def categorize(desc):
    d = desc.lower()
    if "mandya organic" in d:
        return "Mandya Organic Foods"
    elif "amazon pay" in d:
        return "Amazon Pay India"
    elif "cult" in d:
        return "Cult"
    elif "top in town" in d:
        return "Top in Town Hypermarket"
    elif "inox" in d or "cinepolis" in d:
        return "Movies & Entertainment"
    elif "medical" in d:
        return "Medical"
    elif "fashion" in d:
        return "Fashion & Apparel"
    elif "retail" in d or "decathlon" in d:
        return "Retail & Sports"
    elif "foodwork" in d:
        return "Food Delivery"
    elif "nexus" in d:
        return "Shopping Mall"
    elif "indian institute" in d:
        return "Education"
    else:
        return "Others"

df["Category"] = df["Description"].apply(categorize)

# Sum amounts by category
summary = df.groupby("Category")["Amount (Rs.)"].sum().reset_index()

# import caas_jupyter_tools
# caas_jupyter_tools.display_dataframe_to_user(name="Total Spend by Category", dataframe=summary)

print(summary)