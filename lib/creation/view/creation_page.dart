import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lavoratori_stagionali/creation/widgets/chip_list.dart';
import 'package:lavoratori_stagionali/creation/widgets/experience_list.dart';
import 'package:lavoratori_stagionali/creation/widgets/licenses_selection_list.dart';
import 'package:lavoratori_stagionali/creation/widgets/period_list.dart';
import 'package:workers_api/workers_api.dart';
import 'package:workers_repository/workers_repository.dart';

import '../bloc/creation_bloc.dart';
import '../widgets/emergency_contact_list.dart';

class CreationPage extends StatelessWidget {
  const CreationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreationBloc(
        workersRepository: context.read<WorkersRepository>(),
      )..add(AllLicensesSubscriptionRequested()),
      child: CreationView(),
    );
  }
}

class CreationView extends StatelessWidget {
  CreationView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: BlocBuilder<CreationBloc, CreationState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: () {
                  context.read<CreationBloc>().add(ResetAllState());
                },
                child: Icon(Icons.clear),
              ),
              SizedBox(
                height: 5,
              ),
              FloatingActionButton(
                onPressed:() {
                  bool allFieldCompiled = allFieldsIsCompiled(
                      languages: state.languages,
                      licenses: state.licenses,
                      areas: state.areas,
                      fields: state.fields,
                      experiences: state.experiences,
                      periods: state.periods,
                      emergencyContacts: state.emergencyContacts
                  );
                  if (_formKey.currentState!.validate() && allFieldCompiled) {
                    Worker worker = Worker(
                        firstname: state.firstname!,
                        lastname: state.lastname!,
                        birthday: DateFormat('dd/MM/yyyy').parse(state.birthday!),
                        birthplace: state.birthplace!,
                        nationality: state.nationality!,
                        address: state.address!,
                        phone: state.phone!,
                        email: state.email!,
                        ownCar: state.ownCar,
                        languages: state.languages,
                        licenses: state.licenses,
                        areas: state.areas,
                        fields: state.fields,
                        experiences: state.experiences,
                        periods: state.periods,
                        emergencyContacts: state.emergencyContacts);
                    context
                        .read<CreationBloc>()
                        .add(WorkerSubmitted(worker));
                    context.read<CreationBloc>().add(ResetAllState());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Aggiunta avvenuta con successo')),
                    );
                  } else
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Compilare tutti i campi obbligatori')),
                    );
                },
                child: Icon(Icons.save),
              )
            ],
          );
        },
      ),
      body: BlocBuilder<CreationBloc, CreationState>(
        builder: (context, state) {
          TextEditingController _firstName =
              TextEditingController(text: state.firstname ?? '');
          TextEditingController _lastName =
              TextEditingController(text: state.lastname ?? '');
          TextEditingController _phone =
              TextEditingController(text: state.phone ?? '');
          TextEditingController _email =
              TextEditingController(text: state.email ?? '');

          TextEditingController _birthday =
              TextEditingController(text: state.birthday ?? '');
          TextEditingController _birthplace =
              TextEditingController(text: state.birthplace ?? '');
          TextEditingController _nationality =
              TextEditingController(text: state.nationality ?? '');
          TextEditingController _address =
              TextEditingController(text: state.address ?? '');

          return SingleChildScrollView(
            controller: ScrollController(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Text(
                    'Aggiungi un nuovo lavoratore',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Form(
                    key: _formKey,
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                        SizedBox(
                            width: size.width * 0.5 - 40,
                            child: Column(
                              children: [
// -- FIRST NAME
                                FocusScope(
                                  onFocusChange: (focus) {
                                    if (!focus) {
                                      context.read<CreationBloc>().add(
                                          FirstNameChanged(_firstName.text));
                                    }
                                  },
                                  child: TextFormField(
                                    controller: _firstName,
                                    decoration: InputDecoration(
                                      labelText: 'Nome*',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty)
                                        return 'Campo obbligatorio';
                                      return null;
                                    },
                                  ),
                                ),

// -- LAST NAME
                                FocusScope(
                                  onFocusChange: (focus) {
                                    if (!focus) {
                                      context
                                          .read<CreationBloc>()
                                          .add(LastNameChanged(_lastName.text));
                                    }
                                  },
                                  child: TextFormField(
                                    controller: _lastName,
                                    decoration: InputDecoration(
                                      labelText: 'Cognome*',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty)
                                        return 'Campo obbligatorio';
                                      return null;
                                    },
                                  ),
                                ),
// -- PHONE
                                FocusScope(
                                  onFocusChange: (focus) {
                                    if (!focus) {
                                      context
                                          .read<CreationBloc>()
                                          .add(PhoneChanged(_phone.text));
                                    }
                                  },
                                  child: TextFormField(
                                    controller: _phone,
                                    decoration: InputDecoration(
                                      labelText: 'Telefono*',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty)
                                        return 'Campo obbligatorio';
                                      String pattern = r'^(?:[+0]9)?[0-9]{10}$';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value))
                                        return 'Inserire un numero di telefono valido';
                                      return null;
                                    },
                                  ),
                                ),
// -- EMAIL
                                FocusScope(
                                  onFocusChange: (focus) {
                                    if (!focus) {
                                      context
                                          .read<CreationBloc>()
                                          .add(EmailChanged(_email.text));
                                    }
                                  },
                                  child: TextFormField(
                                    controller: _email,
                                    decoration: InputDecoration(
                                      labelText: 'E-mail*',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty)
                                        return 'Campo obbligatorio';
                                      String pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value))
                                        return 'Inserire una email valida';
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          width: size.width * 0.5 - 40,
                          child: Column(
                            children: [
// -- BIRTHDAY
                              FocusScope(
                                onFocusChange: (focus) {
                                  if (!focus) {
                                    context
                                        .read<CreationBloc>()
                                        .add(BirthdayChanged(_birthday.text));
                                  }
                                },
                                child: TextFormField(
                                  controller: _birthday,
                                  decoration: InputDecoration(
                                    labelText: 'Data di nascita (gg/mm/aaaa)*',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty)
                                      return 'Campo obbligatorio';
                                    try {
                                      DateFormat('dd/MM/yyyy').parse(value);
                                    } catch (e) {
                                      return 'Inserire una data valida';
                                    }
                                    return null;
                                  },
                                ),
                              ),

// -- BIRTHPLACE
                              FocusScope(
                                onFocusChange: (focus) {
                                  if (!focus) {
                                    context.read<CreationBloc>().add(
                                        BirthplaceChanged(_birthplace.text));
                                  }
                                },
                                child: TextFormField(
                                  controller: _birthplace,
                                  decoration: InputDecoration(
                                    labelText: 'Luogo di nascita*',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty)
                                      return 'Campo obbligatorio';
                                    return null;
                                  },
                                ),
                              ),

// -- NATIONALITY
                              FocusScope(
                                onFocusChange: (focus) {
                                  if (!focus) {
                                    context.read<CreationBloc>().add(
                                        NationalityChanged(_nationality.text));
                                  }
                                },
                                child: TextFormField(
                                  controller: _nationality,
                                  decoration: InputDecoration(
                                    labelText: 'Nazionalità*',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty)
                                      return 'Campo obbligatorio';
                                    return null;
                                  },
                                ),
                              ),

// -- ADDRESS
                              FocusScope(
                                onFocusChange: (focus) {
                                  if (!focus) {
                                    context
                                        .read<CreationBloc>()
                                        .add(AddressChanged(_address.text));
                                  }
                                },
                                child: TextFormField(
                                  controller: _address,
                                  decoration: InputDecoration(
                                    labelText:
                                        'Indirizzo (Via/Piazza, Comune, CAP)*',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty)
                                      return 'Campo obbligatorio';
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
// //LANGUAGES
                        SizedBox(
                          width: size.width * 0.5 - 40,
                          child: ChipList(
                            width: size.width * 0.5 - 40,
                            title: 'Lingue parlate*',
                            hint: 'Lingua',
                            list: state.languages,
                            onAdd: (string) => context
                                .read<CreationBloc>()
                                .add(LanguageAdded(string)),
                            onDelete: (string) => context
                                .read<CreationBloc>()
                                .add(LanguageDeleted(string)),
                          ),
                        ),
//LICENSES
                        SizedBox(
                          width: size.width * 0.5 - 40,
                          child: LicensesSelection(
                            width: size.width * 0.5 - 40,
                            title: 'Patenti possedute:',
                            hint: 'Patente',
                            licenses: state.allLicenses,
                            selected: state.licenses,
                            onAdd: (string) => context
                                .read<CreationBloc>()
                                .add(LicenseAdded(string)),
                            onDelete: (string) => context
                                .read<CreationBloc>()
                                .add(LicenseDeleted(string)),
                          ),
                        ),
//AREAS
                        SizedBox(
                          width: size.width * 0.5 - 40,
                          child: ChipList(
                            width: size.width * 0.5 - 40,
                            title: 'Zone*:',
                            hint: 'Comune',
                            list: state.areas,
                            onAdd: (string) => context
                                .read<CreationBloc>()
                                .add(AreaAdded(string)),
                            onDelete: (string) => context
                                .read<CreationBloc>()
                                .add(AreaDeleted(string)),
                          ),
                        ),
//OWN CAR
                        SizedBox(
                          width: size.width * 0.5 - 40,
                          child: Row(
                            children: [
                              Text(
                                'Automunito',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Checkbox(
                                value: state.ownCar,
                                onChanged: (bool? value) {
                                  if (value != null) {
                                    context
                                        .read<CreationBloc>()
                                        .add(OwnCarChanged(value));
                                  }
                                },
                              )
                            ],
                          ),
                        ),
//TASKS
                        SizedBox(
                          width: size.width * 0.5 - 40,
                          child: ChipList(
                            width: size.width * 0.5 - 40,
                            title: 'Campo*:',
                            hint: 'agricoltura/turismo',
                            list: state.fields,
                            onAdd: (string) => context
                                .read<CreationBloc>()
                                .add(FieldAdded(string)),
                            onDelete: (string) => context
                                .read<CreationBloc>()
                                .add(FieldDeleted(string)),
                          ),
                        ),
//PERIODS
                        SizedBox(
                          width: size.width * 0.5 - 40,
                          child: PeriodList(
                            width: size.width * 0.5 - 40,
                            title: 'Periodi*:',
                            hint: 'Aggiungi perido',
                            list: state.periods,
                            onAdd: (range) {
                              context
                                  .read<CreationBloc>()
                                  .add(PeriodAdded(range.start, range.end));
                            },
                            onDelete: (element) {
                              context
                                  .read<CreationBloc>()
                                  .add(PeriodDeleted(element));
                            },
                          ),
                        ),
//EXPERIENCES
                        SizedBox(
                          width: size.width,
                          child: ExperienceList(
                            width: size.width,
                            height: size.height,
                            title: 'Esperienze lavorative: ',
                            hint: 'Aggiungi esperienza lavorativa',
                            list: state.experiences,
                            onAdd: (experience) {
                              context
                                  .read<CreationBloc>()
                                  .add(ExperienceAdded(experience));
                            },
                            onDelete: (experience) {
                              context
                                  .read<CreationBloc>()
                                  .add(ExperienceDeleted(experience));
                            },
                          ),
                        ),
//CONTACTS
                        SizedBox(
                          width: size.width,
                          child: EmergencyContactList(
                            width: size.width,
                            height: size.height,
                            title: 'Contatti di emergenza*: ',
                            hint: 'Aggiungi contatto di emergenza',
                            list: state.emergencyContacts,
                            onAdd: (emergencyContact) {
                              context
                                  .read<CreationBloc>()
                                  .add(EmergencyContactAdded(emergencyContact));
                            },
                            onDelete: (experience) {
                              context
                                  .read<CreationBloc>()
                                  .add(EmergencyContactDeleted(experience));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool allFieldsIsCompiled({
    required final List<String> languages,
    required final List<String> licenses,
    required final List<String> areas,
    required final List<String> fields,
    required final List<Experience> experiences,
    required final List<Period> periods,
    required final List<EmergencyContact> emergencyContacts,
  }) {
    if (languages.isNotEmpty &&
        areas.isNotEmpty &&
        fields.isNotEmpty &&
        periods.isNotEmpty &&
        emergencyContacts.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
