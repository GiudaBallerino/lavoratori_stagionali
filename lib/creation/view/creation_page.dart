import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lavoratori_stagionali/creation/widgets/chip_list.dart';
import 'package:workers_repository/workers_repository.dart';

import '../bloc/creation_bloc.dart';

class CreationPage extends StatelessWidget {
  const CreationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreationBloc(
        workersRepository: context.read<WorkersRepository>(),
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
      body: BlocListener<CreationBloc, CreationState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          // if (state.status == CreationStatus.failure) {
          //   ScaffoldMessenger.of(context)
          //     ..hideCurrentSnackBar()
          //     ..showSnackBar(
          //       SnackBar(
          //         content: Text("Aggiunta fallita"),
          //       ),
          //     );
          // } else if (state.status == CreationStatus.success) {
          //   ScaffoldMessenger.of(context)
          //     ..hideCurrentSnackBar()
          //     ..showSnackBar(
          //       SnackBar(
          //         content: Text("Aggiunta avvenuta con successo"),
          //       ),
          //     );
          // }
        },
        child: BlocBuilder<CreationBloc, CreationState>(
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

            TextEditingController _language = TextEditingController();
            TextEditingController _license = TextEditingController();

            return SingleChildScrollView(
              controller: ScrollController(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Text(
                      'Aggiungi un nuovo lavoratore',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                                        context.read<CreationBloc>().add(
                                            LastNameChanged(_lastName.text));
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
                                          NationalityChanged(
                                              _nationality.text));
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
                            child: Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              children: [
                                SizedBox(
                                  width: size.width * 0.5 - 40,
                                  child: Text(
                                    'Periodi:',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                for (final element in state.periods)
                                  InputChip(
                                    label:
                                        Text('${DateFormat('dd/MM/yyyy').format(element.start)} - ${DateFormat('dd/MM/yyyy').format(element.end)}'),
                                    onDeleted: () => context
                                        .read<CreationBloc>()
                                        .add(PeriodDeleted(element)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 13),
                                  ),
                                InputChip(
                                  label: Text('Aggiungi periodo'),
                                  onPressed: () async {
                                    final DateTimeRange? result = await showDateRangePicker(
                                      context: context,
                                      initialEntryMode: DatePickerEntryMode.calendar,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2030, 12, 31),
                                      currentDate: DateTime.now(),
                                      helpText: 'SELEZIONA DATE',
                                      fieldStartHintText: 'Data di inizio',
                                      fieldEndLabelText: 'Data di inizio',
                                      fieldEndHintText: 'Data di fine',
                                      fieldStartLabelText:'Data di fine',
                                      saveText: 'Fatto',
                                    );

                                    if(result!=null){
                                      context
                                          .read<CreationBloc>()
                                          .add(PeriodAdded(result.start,result.end));
                                    }

                                  },
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 13),
                                ),
                              ],
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
      ),
    );
  }
}
