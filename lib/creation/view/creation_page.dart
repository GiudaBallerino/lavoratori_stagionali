import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lavoratori_stagionali/creation/widgets/chip_list.dart';
import 'package:lavoratori_stagionali/creation/widgets/experience_list.dart';
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
      )..add(
        const WorkersSubscriptionRequested(),
      ),
      child: const CreationView(),
    );
  }
}

class CreationView extends StatelessWidget {
  const CreationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: BlocBuilder<CreationBloc, CreationState>(
        builder: (context, state) {
          if (allFieldsIsCompiled(
              firstname: state.firstname,
              lastname: state.lastname,
              birthday: state.birthday,
              birthplace: state.birthplace,
              nationality: state.nationality,
              address: state.address,
              phone: state.phone,
              email: state.email,
              languages: state.languages,
              licenses: state.licenses,
              areas: state.areas,
              tasks: state.tasks,
              experiences: state.experiences,
              periods: state.periods,
              emergencyContacts: state.emergencyContacts)) {
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
                  onPressed: () {
                    Worker worker = Worker(
                        firstname: state.firstname!,
                        lastname: state.lastname!,
                        birthday: state.birthday!,
                        birthplace: state.birthplace!,
                        nationality: state.nationality!,
                        address: state.address!,
                        phone: state.phone!,
                        email: state.email!,
                        languages: state.languages,
                        licenses: state.licenses,
                        areas: state.areas,
                        tasks: state.tasks,
                        experiences: state.experiences,
                        periods: state.periods,
                        emergencyContacts: state.emergencyContacts);
                    context.read<CreationBloc>().add(WorkerSubmitted(worker));
                    print(state.status);
                    print(worker.toJson());
                  },
                  child: Icon(Icons.save),
                )
              ],
            );
          } else {
            return FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                context.read<CreationBloc>().add(ResetAllState());
              },
              child: Icon(Icons.clear),
            );
          }
        },
      ),
      body: BlocBuilder<CreationBloc, CreationState>(
        builder: (context, state) {
          final _formKey = GlobalKey<FormState>();

          //todo creare stato e eventi per tutti questi
          TextEditingController _firstName =
              TextEditingController(text: state.firstname ?? '');
          TextEditingController _lastName =
              TextEditingController(text: state.lastname ?? '');
          TextEditingController _phone =
              TextEditingController(text: state.phone ?? '');
          TextEditingController _email =
              TextEditingController(text: state.email ?? '');

          TextEditingController _birthday = TextEditingController(
              text: state.birthday != null
                  ? DateFormat('dd/MM/yyyy').format(state.birthday!)
                  : '');
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
                                      labelText: 'Nome',
                                    ),
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
                                      labelText: 'Cognome',
                                    ),
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
                                      labelText: 'Telefono',
                                    ),
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
                                      labelText: 'E-mail',
                                    ),
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
                                    labelText: 'Data di nascita (GG/MM/AAAA)',
                                  ),
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
                                    labelText: 'Luogo di nascita',
                                  ),
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
                                    labelText: 'Nazionalità',
                                  ),
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
                                        'Indirizzo (Via/Piazza, Comune, CAP)',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.5 - 40,
                          child: ChipList(
                            width: size.width * 0.5 - 40,
                            title: 'Lingue parlate',
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
                        SizedBox(
                          width: size.width * 0.5 - 40,
                          child: ChipList(
                            width: size.width * 0.5 - 40,
                            title: 'Patenti possedute:',
                            hint: 'Patente',
                            list: state.licenses,
                            onAdd: (string) => context
                                .read<CreationBloc>()
                                .add(LicenseAdded(string)),
                            onDelete: (string) => context
                                .read<CreationBloc>()
                                .add(LicenseDeleted(string)),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.5 - 40,
                          child: ChipList(
                            width: size.width * 0.5 - 40,
                            title: 'Zone:',
                            hint: 'Zona',
                            list: state.areas,
                            onAdd: (string) => context
                                .read<CreationBloc>()
                                .add(AreaAdded(string)),
                            onDelete: (string) => context
                                .read<CreationBloc>()
                                .add(AreaDeleted(string)),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.5 - 40,
                          child: ChipList(
                            width: size.width * 0.5 - 40,
                            title: 'Esperienze/specializzazioni:',
                            hint: 'esperienza/specializzazione',
                            list: state.tasks,
                            onAdd: (string) => context
                                .read<CreationBloc>()
                                .add(TaskAdded(string)),
                            onDelete: (string) => context
                                .read<CreationBloc>()
                                .add(TaskDeleted(string)),
                          ),
                        ),
                        SizedBox(
                          width: size.width,
                          child: PeriodList(
                            width: size.width,
                            title: 'Periodi:',
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
                        SizedBox(
                          width: size.width,
                          child: EmergencyContactList(
                            width: size.width,
                            height: size.height,
                            title: 'Contatti di emergenza: ',
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
    required final String? firstname,
    required final String? lastname,
    required final DateTime? birthday,
    required final String? birthplace,
    required final String? nationality,
    required final String? address,
    required final String? phone,
    required final String? email,
    required final List<String> languages,
    required final List<String> licenses,
    required final List<String> areas,
    required final List<String> tasks,
    required final List<Experience> experiences,
    required final List<Period> periods,
    required final List<EmergencyContact> emergencyContacts,
  }) {
    if (firstname != null &&
        firstname != '' &&
        lastname != null &&
        lastname != '' &&
        birthday != null &&
        birthplace != null &&
        birthplace != '' &&
        nationality != null &&
        nationality != '' &&
        address != null &&
        address != '' &&
        phone != null &&
        phone != '' &&
        email != null &&
        email != '' &&
        languages.isNotEmpty &&
        //licenses.isNotEmpty &&
        areas.isNotEmpty &&
        tasks.isNotEmpty &&
        periods.isNotEmpty &&
        //experiences.isNotEmpty &&
        emergencyContacts.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
