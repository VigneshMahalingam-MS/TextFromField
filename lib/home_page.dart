import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController dob = TextEditingController();

  String? gender;
  List<String> selectedDepartments = [];
  String? hasDepartment;
  List<Map<String, String>> users = [];
  final List<String> departments = [
    "AR",
    "FLUTTER",
    "REACT",
    "PYTHON",
  ];

  final _userSignupKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Userpage"),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Form(
                    key: _userSignupKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: username,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Entre Your User Name";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: "User Name",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: phone,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Entre Your User Phone";
                              }
                              if (value.length < 10) {
                                return "Entre Your 10digit phoneno";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: "Phone",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Entre Your User Email";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: password,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Entre Your User Password";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          DropdownButtonFormField<String>(
                            value: gender,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Entre Your Gender";
                              }
                              return null;
                            },
                            items: const [
                              DropdownMenuItem(
                                value: "male",
                                child: Text("male"),
                              ),
                              DropdownMenuItem(
                                value: "female",
                                child: Text("female"),
                              ),
                              DropdownMenuItem(
                                value: "others",
                                child: Text("others"),
                              )
                            ],
                            onChanged: (value) {
                              setState(() {
                                gender = value;
                              });
                            },
                            decoration: InputDecoration(
                                labelText: gender,
                                border: const OutlineInputBorder()),
                          ),
                          const SizedBox(height: 20),
                          const Text("Select your depatment"),
                          Column(
                              children: departments.map((dept) {
                            return CheckboxListTile(
                                title: Text(dept),
                                value: selectedDepartments.contains(dept),
                                onChanged: (isSelected) {
                                  setState(() {
                                    if (isSelected == true) {
                                      selectedDepartments.add(dept);
                                    } else {
                                      selectedDepartments.remove(dept);
                                    }
                                  });
                                });
                          }).toList()),
                          const SizedBox(height: 20),
                          const Text("Have you chosen a department?"),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  title: const Text("Yes"),
                                  value: "Yes",
                                  groupValue: hasDepartment,
                                  onChanged: (value) {
                                    setState(() {
                                      hasDepartment = value;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  title: const Text("No"),
                                  value: "No",
                                  groupValue: hasDepartment,
                                  onChanged: (value) {
                                    setState(() {
                                      hasDepartment = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: dob,
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Entre Your User Dob ";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Date of Birth",
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  DateTime? selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now(),
                                  );
                                  if (selectedDate != null) {
                                    setState(() {
                                      dob.text = DateFormat("dd-MM-yyyy")
                                          .format(selectedDate);
                                    });
                                  }
                                },
                                icon: const Icon(
                                  Icons.calendar_today,
                                ),
                                color: Colors.red,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber),
                            onPressed: () {
                              if (_userSignupKey.currentState!.validate()) {
                                if (gender == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Please select a gender')),
                                  );
                                  return;
                                }
                                if (hasDepartment == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Please choose if you have a department')),
                                  );
                                  return;
                                }
                                if (dob.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Please select a date of birth')),
                                  );
                                  return;
                                }
                                if (selectedDepartments.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Please select at least one department')),
                                  );
                                  return;
                                }

                                setState(() {
                                  users.add({
                                    'username': username.text,
                                    'phone': phone.text,
                                    'email': email.text,
                                    'gender': gender!,
                                    'dob': dob.text,
                                    'department':
                                        selectedDepartments.join(", "),
                                    'hasDepartment': hasDepartment!,
                                  });

                                  username.clear();
                                  phone.clear();
                                  email.clear();
                                  password.clear();
                                  dob.clear();
                                  gender = null;
                                  selectedDepartments.clear();
                                  hasDepartment = null;
                                });
                              }
                            },
                            child: const Text("Add User"),
                          )
                        ],
                      ),
                    )),
              )),
          const Divider(),
          Expanded(
              flex: 1,
              child: users.isEmpty
                  ? const Center(child: Text('No users'))
                  : ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(users[index]['username']!),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Email: ${users[index]['email']!}"),
                              Text("Gender: ${users[index]['gender']!}"),
                              Text("DOB: ${users[index]['dob']!}"),
                              Text(
                                  "Departments: ${users[index]['department']!}"),
                              Text(
                                  "Has Department: ${users[index]['hasDepartment']!}"),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                users.removeAt(index);
                              });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        );
                      }))
        ],
      )),
    );
  }
}
