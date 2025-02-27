class Rectangle:
    def __init__(self, width, height):
        self.width = width
        self.height = height

    def __str__(self):
        return f"{self.__class__.__name__}(width={self.width}, height={self.height})"

    def set_width(self, width):
        self.width = width
    
    def set_height(self, height):
        self.height = height
    
    def get_area(self):
        return self.width * self.height

    def get_perimeter(self):
        return (2*self.width + 2*self.height)

    def get_diagonal(self):
        return ((self.width**2 + self.height**2)**.5)

    def get_picture(self):
        if self.width > 50 or self.height > 50:
            return "Too big for picture."
        
        output_str = ""
        for i in range(self.height):
            output_str += ("*"*self.width + "\n")
        return output_str

    def get_amount_inside(self, shape):
        amount = self.width // shape.width * self.height // shape.height
        return amount

class Square(Rectangle):
    def __init__(self, side):
        self.side = side
        super().__init__(width=self.side, height=self.side)


    def __str__(self):
        return f"{self.__class__.__name__}(side={self.side})"
    
    def set_width(self, width):
        self.width = width
        self.height = width
        self.side = width

    def set_height(self, height):
        self.height = height
        self.width = height
        self.side = height

    def set_side(self, side):
        self.side = side
        self.width = side
        self.height = side

    

# ## Usage example
# rect = Rectangle(10, 5)
# print(rect.get_area())
# rect.set_height(3)
# print(rect.get_perimeter())
# print(rect)
# print(rect.get_picture())
# 
# sq = Square(9)
# print(sq.get_area())
# sq.set_side(4)
# print(sq.get_diagonal())
# print(sq)
# print(sq.get_picture())
# 
# rect.set_height(8)
# rect.set_width(16)
# print(rect.get_amount_inside(sq))
# 
# ## Tests
# rec_test = Rectangle(3, 6)
# print(rec_test)
# print(rec_test.get_area())
# print(rec_test.get_perimeter())
# print(rec_test.get_diagonal())
# print(Rectangle(45, 55).get_picture())
# 
# sq_test = Square(5)
# print(sq_test)
# print(sq_test.get_area())
# print(sq_test.get_perimeter())
# print(sq_test.get_diagonal())
# print(Square(56).get_picture())
# 
# print(Rectangle(15,10).get_amount_inside(Square(5)))
# print(Rectangle(4,8).get_amount_inside(Rectangle(3, 6)))
# print(Rectangle(2,3).get_amount_inside(Rectangle(3, 6)))
