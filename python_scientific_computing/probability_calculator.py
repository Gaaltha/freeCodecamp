import copy
import random

class Hat:
    def __init__(self, **contents):
        self.contents = [k for k in contents for v in range(contents[k])]
        

    def draw(self, num_balls):
        # Empty self.contents, return all the balls
        if num_balls > len(self.contents):
            cp = self.contents[:]
            self.contents.clear()
            return cp
        
        draws = [
                self.contents.pop(random.randrange(len(self.contents))) for _ in range(num_balls)
            ]
        
        return draws
    
def experiment(hat, expected_balls, num_balls_drawn, num_experiments):
    M = 0
    N = num_experiments

    # Loop for each experiment
    for _ in range(N):
        # Iterate over a deepcopy of hat to start in the same state
        hat_dcopy = copy.deepcopy(hat)
        hat_draw = hat_dcopy.draw(num_balls_drawn)

        # For each color in expected_balls, check that the number drawn is at least equal to the number expected
        if all(hat_draw.count(color) >= expected_num for color, expected_num in expected_balls.items()):
            M += 1
            
    return M/N    


## Example code 
hat1 = Hat(yellow=3, blue=2, green=6)     
hat2 = Hat(red=5, orange=4)
hat3 = Hat(red=5, orange=4, black=1, blue=0, pink=2, striped=9)
hat2_draw = hat2.draw(4)
print(set([(color, hat2_draw.count(color)) for color in hat3.contents]))
# print([ x.contents for x in (hat1, hat2, hat3)

## Tests
hat = Hat(black=6, red=4, green=3)
probability = experiment(hat=hat,
                  expected_balls={'red':2,'green':1},
                  num_balls_drawn=5,
                  num_experiments=2000)
print(probability)         
