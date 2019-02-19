/******************
 Name: Omid Azodi
 Class: CS646 iOS (In-Class)
 Professor: Dr. Whitney
 Due Date: Sept. 8
 Assignment: Assignment #1
 
 Objective:
 1. Get started using Xcode.
 2. Learn basic Swift
 
 Ran with Playground Settings:
 Platform: macOS
 
 Note:
 You can remove the test arrays and calls
 to the functions, I know you can view the answers
 and line by line interpretation of the variables
 and function return values, but I like to call them
 and view it from the output view
 ******************/

/*
 Question 1:
     Create a function squaredSums with one argument an Array of Int. Using the forEach
     return the sum of the squares of the elements of the array. So an input of [1,2,3] would
     return 1 + 2*2 + 3*3 = 14.
 */

func squaredSums(num_array: [Int]) -> Int
{
    var sum_squares = 0
    
    // traverse through array and calculate the square
    // of each value and add to running total
    num_array.forEach
    {
            number in num_array
            sum_squares = sum_squares + (number * number)
    } // num_array.forEach
    
    return sum_squares
} // func squaredSums(num_array: [Int]) -> Int

// test input and output below
let test_array = [1,2,3]
print("Output Question 1: ")
print(squaredSums(num_array: test_array))

/*
 Question 2:
     Create a function squaredSums2 with one argument an Array of Int. Using the forEach
     return the sum of the squares of the even elements of the array. So an input of [1,2,3]
     would return 2*2 = 4.
 */

func squaredSums2(num_array: [Int]) -> Int
{
    var sum_even_squares = 0
    
    // traverse through array and calculate the square for even numbers
    // of each value and add to running total
    num_array.forEach
        {
            number in num_array
            if number % 2 == 0
            {
                sum_even_squares = sum_even_squares + (number * number)
            } //if number % 2 == 0
    } // num_array.forEach
    
    return sum_even_squares
} // func squaredSums2(num_array: [Int]) -> Int


// test input and output below
let test_array_2 = [1,2,3]
print("Output Question 2: ")
print(squaredSums2(num_array: test_array_2))

/*
 Question 3:
     Create a function squaredSums3 with one argument an Array of optional Ints. Using
     the forEach return the sum of the squares of the even elements of the array. So an input
     of [1,2,3,nil] would return 2*2 = 4.
 */

// Note: [Int?] means optional array
func squaredSums3(num_array:[Int?]) -> Int
 {
    var sum_even_squares = 0
 
    num_array.forEach
    {
        if let number = $0
        {
            if number % 2 == 0
            {
                sum_even_squares = sum_even_squares + (number * number)
            }
        }
    }
    return sum_even_squares
 } // func squaredSums3(num_array: [Int]?) -> Int
 
// test input and output below
let test_array_3:[Int?] = [1,2,3,nil]
print("Output Question 3: ")
print(squaredSums3(num_array: test_array_3))

/*
 Question 4:
     Create a function squaredSums4 with one argument an optional Array of Ints. Using
     the forEach return an optional Int, the sum of the squares of the even elements of the
     array. So an input of [1,2,3] would return 2*2 = 4.
 */

func squaredSums4(num_array:[Int]?)->Int?
{
    // optional int
    var sum_even_squares:Int? = 0
    
    if let array = num_array
    {
        array.forEach
        {
            if $0 % 2 == 0
            {
                sum_even_squares! += ($0 * $0)
            }
        }
    }
    return sum_even_squares
}

// test input and output below
let test_array_4:[Int]? = [1,2,3,4,5,6]
// should be (2 * 2) + (4 * 4) + (6 * 6) = 20 + 36 = 56
print("Output Question 4: ")
print(squaredSums4(num_array:test_array_4))

/*
 Question 5:
     Create a function squaredSums5 with one argument an Array of Int. Using the filter
     and reduce return the sum of the squares of the even elements of the array. So an input of
     [1,2,3] would return 2*2 = 4.
*/

func squaredSums5(num_array:[Int]) -> Int
{
    let filtered_array = num_array.filter
    {
        // even values
        $0 % 2 == 0
    }
    
    let sum_even_squares = filtered_array.reduce(0,
        {
            sum_even_squares,
            number in (sum_even_squares + (number * number))
        }
    )
    return sum_even_squares
}

// test input and array
let test_array_5:[Int] = [1,2,3,4]
print("Output Question 5:")
print(squaredSums5(num_array:test_array_5))

/*
 Question 6:
     Create a function squaredSums6 with one argument a Collection of Int. Using the
     filter and reduce return the sum of the squares of the even elements of the array. So an input
     of [1,2,3] would return 2*2 = 4.
*/

func squaredSums6(num_collection: [Int]) -> Int
{
    let filtered_collection_array = num_collection.filter
    {
        // even values
        $0 % 2 == 0
    }
    
    let sum_even_squares = filtered_collection_array.reduce(0,
         {
            sum_even_squares,
            number in (sum_even_squares + (number * number))
         }
    )
    return sum_even_squares
}

// test input and array
let test_array_6:[Int] = [1,2,3,4,5,6]
print("Output Question 6:")
print(squaredSums5(num_array:test_array_6))

/*
 Question 7:
     Create a Student Struct that contains a name, red id, number of units taken and
     GPA. The struct needs one method priority which returns the number of units taken times
     the GPA.
*/

struct Student
{
    var name:String = "" // First, Last
    var red_id:String = "" // usualy an example of ### ### ###
    var number_of_units_taken:Int = -1 // 0 - whatever you can handle :)
    var gpa:Double = -1.0 // 0.0 - 4.0 is valid (double)
    
    // method priority will return
    // the gpa * # of units
    func priority() -> Double
    {
        return Double(Double(self.number_of_units_taken) * Double(self.gpa) )
    }
    
    // function to print all values
    // of instance when created
    func printStudentValues()
    {
        print("\nName = ", self.name)
        print("Red Id = ", self.red_id)
        print("# of units taken = ", self.number_of_units_taken)
        print("GPA = ", self.gpa)
        print("Priority = ", self.priority())
    }
    // do not need init function for struct
    // automatically generated
}

// test input and print values
var student_1 =
    Student(name: "Omid Azodi",
            red_id: "816736590",
            number_of_units_taken: 6,
            gpa: 3.0)

/*
 Question 8:
    Create priority queue class. The add method added elements to the queue. The
    first method returns the element with the highest priority. The
    removeFirst removes the element with the highest priority and returns it.
    The queue needs to be able to hold Student structs from problem 7.
*/


class PriorityQueue
{
    // our array of students
    // could make it optional students
    // to account for nils but was not specified
    // so I went ahead with just making an array of Students
    var students = [Student]()
    
    // add method adds elements to the queue
    func add(student_element:Student)
    {
        self.students.append(student_element)
        self.students = self.students.sorted(by: {$0.priority() > $1.priority()} )
    } // func add()
    
    // returns element with the highest priority
    // which will be the first element in the
    // priority queue
    func first() -> Student
    {
       // ensure one student exists
       if self.number_of_students() >= 1
       {
         return students[0]
       }
        
        // otherwise return a default student
        return Student()
    }
    
    func removeFirst() -> Student
    {
        // need to remove first element
        // since that has the highest priority
        
        // remove only if there is at least 1 or
        // more elements in the priority queue
        if(self.number_of_students() >= 1)
        {
            self.students.remove(at:0)
        }
        
        return self.first()
    }
    
    // returns the # of students in the priority queue
    func number_of_students() -> Int
    {
        return self.students.count
    }
    
    // print all information of all elements
    // in the priority queue
    func print_queue()
    {
        self.students.forEach
        {
            $0.printStudentValues()
        }
    }
    
}

var student_2 =
    Student(name: "Second Student",
            red_id: "123456789",
            number_of_units_taken: 3,
            gpa: 3.0)

var student_3 =
    Student(name: "Third Student",
            red_id: "389888746",
            number_of_units_taken: 12,
            gpa: 4.0)

var student_4 =
    Student(name: "Fourth Student",
            red_id: "777888999",
            number_of_units_taken: 3,
            gpa: 3.0)

var priority_queue = PriorityQueue()

priority_queue.add(student_element: student_2)
priority_queue.add(student_element: student_1)
priority_queue.add(student_element: student_4)
priority_queue.add(student_element: student_3)
priority_queue.print_queue()
priority_queue.removeFirst()
priority_queue.print_queue()
priority_queue.first().printStudentValues()



