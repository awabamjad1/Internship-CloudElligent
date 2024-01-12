from flask import Flask, jsonify, request

app = Flask(__name__)

class Person:
    def __init__(self, name, age, gender):
        self.name = name
        self.age = age
        self.gender = gender

    def display_info(self):
        return {
            'name': self.name,
            'age': self.age,
            'gender': self.gender
        }


class Student(Person):
    def __init__(self, name, age, gender, student_id, grade):
        super().__init__(name, age, gender)
        self.student_id = student_id
        self.grade = grade

    def display_info(self):
        person_info = super().display_info()
        person_info.update({
            'student_id': self.student_id,
            'grade': self.grade
        })
        return person_info


class Teacher(Person):
    def __init__(self, name, age, gender, employee_id, subject):
        super().__init__(name, age, gender)
        self.employee_id = employee_id
        self.subject = subject

    def display_info(self):
        person_info = super().display_info()
        person_info.update({
            'employee_id': self.employee_id,
            'subject': self.subject
        })
        return person_info


class Staff(Person):
    def __init__(self, name, age, gender, employee_id, department):
        super().__init__(name, age, gender)
        self.employee_id = employee_id
        self.department = department

    def display_info(self):
        person_info = super().display_info()
        person_info.update({
            'employee_id': self.employee_id,
            'department': self.department
        })
        return person_info


students = {}
teachers = {}
staff = {}

@app.route('/', methods=['GET'])
def health_check():
    return jsonify({'status': 'healthy'}), 200


@app.route('/students/<int:student_id>', methods=['GET'])
def get_student(student_id):
    student = students.get(student_id)
    if student:
        return jsonify(student.display_info())
    return jsonify({'error': 'Student not found'}), 404


@app.route('/teachers/<int:teacher_id>', methods=['GET'])
def get_teacher(teacher_id):
    teacher = teachers.get(teacher_id)
    if teacher:
        return jsonify(teacher.display_info())
    return jsonify({'error': 'Teacher not found'}), 404


@app.route('/staff/<int:staff_id>', methods=['GET'])
def get_staff(staff_id):
    staff_member = staff.get(staff_id)
    if staff_member:
        return jsonify(staff_member.display_info())
    return jsonify({'error': 'Staff member not found'}), 404


@app.route('/students', methods=['POST'])
def add_student():
    data = request.json
    student_id = data.get('student_id')
    if student_id in students:
        return jsonify({'error': 'Student ID already exists'}), 400

    student = Student(data['name'], data['age'], data['gender'], student_id, data['grade'])
    students[student_id] = student
    return jsonify({'message': 'Student added successfully'}), 201


@app.route('/teachers', methods=['POST'])
def add_teacher():
    data = request.json
    employee_id = data.get('employee_id')
    if employee_id in teachers:
        return jsonify({'error': 'Employee ID already exists'}), 400

    teacher = Teacher(data['name'], data['age'], data['gender'], employee_id, data['subject'])
    teachers[employee_id] = teacher
    return jsonify({'message': 'Teacher added successfully'}), 201


@app.route('/staff', methods=['POST'])
def add_staff():
    data = request.json
    employee_id = data.get('employee_id')
    if employee_id in staff:
        return jsonify({'error': 'Employee ID already exists'}), 400

    staff_member = Staff(data['name'], data['age'], data['gender'], employee_id, data['department'])
    staff[employee_id] = staff_member
    return jsonify({'message': 'Staff member added successfully'}), 201

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
