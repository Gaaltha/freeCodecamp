class Category:
    def __init__(self, category):
        self.category = category.title()
        self.ledger = []
    

    def __str__(self):
        # Format lines in self.ledger
        ledger_list = []
        for item in self.ledger:
            des = item["description"][:23]
            amount = "{:.2f}".format(item["amount"])[:7]
            ledger_list.append("\n" + des + " "*(30-(len(des) + len(amount))) + amount)

        total = f"\nTotal: {self.get_balance():.2f}"
        
        return self.category.center(30, "*") + "".join(ledger_list) + total
    

    def deposit(self, amount, description=""):  
        self.ledger.append({"amount": amount, "description": description})

    def withdraw(self, amount, description=""):
        # If there are the necessary funds
        if self.check_funds(amount):
            self.ledger.append({"amount": -amount, "description": description})
            return True
        return False
    
    def _get_balance(self, ledger):
        balance = 0
        for transaction in ledger:
            balance += transaction["amount"]
        return balance

    def get_balance(self):
        return self._get_balance(self.ledger)

    def transfer(self, amount, category):
        if self.check_funds(amount):
            self.withdraw(amount, f"Transfer to {category.category}")
            category.deposit(amount, f"Transfer from {self.category}")
            return True
        return False
    
    def check_funds(self, amount):
        if self.get_balance() >= amount:
            return True
        return False


def create_spend_chart(categories):
    title = "Percentage spent by category\n"
    y_headers = [[(str(i) + "|").rjust(4)] for i in range(100, -10, -10)]
    
    bottom_line = ["---" if i > 0 else "    " for i in range(len(categories)+1)] + ["-"]
    bottom_line = "".join(bottom_line)
    
    x_headers = [[] if i > 0 else ["".rjust(4)] for i in range(len(categories)+1)]
    
    # Make a dict with values for each category in categories: Category, total amount withdrawn, %age
    dct_withdrawals = []
    for category in categories:
        # Find the total of withdrawn money per category
        cat_withdraw = 0
        for transaction in category.ledger:
            if transaction["amount"] < 0:
                cat_withdraw -= transaction["amount"]
        dct_withdrawals.append({"Category":category.category, "Withdrawn":cat_withdraw})

    # Find total amount withdrawn per category & percentage  
    total_withdrawn = 0
    for cat in dct_withdrawals:
        total_withdrawn += cat["Withdrawn"]
    for cat in dct_withdrawals:
        p100 = int((100*cat["Withdrawn"]/total_withdrawn))//10
        cat["p100"] = p100
    
    
    # Make bars
    for y in y_headers:
        for row in dct_withdrawals:
            # y_header[0] is max p100: itereate in reverse
            if y_headers[::-1].index(y) <= row["p100"]:
                y.append("o".ljust(2, " "))
            else:
                y.append("".ljust(2))
        #Whitespace for exercice constraints
        y.append("")

    
    # # Make rows in x_headers
    # Find longest category header
    longest_cat_len = 0
    for cat in dct_withdrawals:
        if len(cat["Category"]) > longest_cat_len:
            longest_cat_len = len(cat["Category"])

    for i in range(longest_cat_len):
        # First column is empty, start at index 1
        header_index = 1
        for item in dct_withdrawals:
            try:
                x_headers[header_index].append(item["Category"][i].ljust(2))

            except IndexError:
                x_headers[header_index].append("".ljust(2))
            header_index += 1
    
    
    # Keep the first column empty and to scale: add whitespace
    x_headers[0] = ["".rjust(4)]*longest_cat_len
    # Whitespace in the rightmost column for consistency and exercise constraints
    x_headers.append([""]*longest_cat_len)
   

    # Append bottom line & rows to columns
    y_headers.append([bottom_line])
    x_headers = [[x[i]  for x in x_headers] for i in range(longest_cat_len)]
    for x in x_headers:
        y_headers.append(x)


    # Format final list
    y_headers = [" ".join(y) for y in y_headers]
    y_headers = "\n".join(y_headers)

    return title + y_headers  
    


test = Category("test")
transfer_test = Category("transfer test")
test.deposit(300, ".deposit() test")
test.deposit(200, ".deposit() test")
test.check_funds(500)
test.withdraw(200, ".withdrawal() test OK")
test.withdraw(700, ".withdrawal() test KO")
test.deposit(23.45)
test.transfer(21, transfer_test)
test.transfer(1.45, transfer_test)
transfer_test.withdraw(3.56)
food = Category('Food')
auto = Category("auto")
food.deposit(1000, 'deposit')
food.withdraw(10.15, 'groceries')
food.withdraw(15.89, 'restaurant and more food for dessert')
clothing = Category('Clothing')
food.transfer(50, clothing)


list_categories = [food, test, transfer_test, clothing]
for l in list_categories:
    print(l, "\n") 

print(create_spend_chart([test, transfer_test, food, clothing]))

