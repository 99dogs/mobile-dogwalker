import 'package:dogwalker/modules/agenda/event.dart';
import 'package:dogwalker/repositories/passeio_repository.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:dogwalker/shared/models/passeio_model.dart';
import 'package:flutter/material.dart';
import 'package:dogwalker/shared/widgets/title_page_widget/title_page_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  final passeioRepository = PasseioRepository();
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  late Map<DateTime, List<Event>> selectedEvents;
  final state = ValueNotifier<StateEnum>(StateEnum.start);

  @override
  void initState() {
    initializeDateFormatting('pt_BR,', null);
    selectedEvents = {};
    buscarPasseios();
    super.initState();
  }

  List<Event> _getEventsFromDay(DateTime date) {
    DateTime _datahora = DateTime(
      date.year,
      date.month,
      date.day,
    );
    return selectedEvents[_datahora] ?? [];
  }

  formatarData(_date) {
    if (_date == null) return "";
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('dd/MM/yyyy HH:mm');
    return outputFormat.format(inputDate).toString();
  }

  Future buscarPasseios() async {
    try {
      state.value = StateEnum.loading;

      List<PasseioModel> passeios = await passeioRepository.buscarTodos();
      passeios.forEach(
        (PasseioModel passeio) {
          String titulo = passeio.tutor!.nome!;
          String subtitulo = passeio.status!;
          DateTime datahora = DateTime.parse(passeio.datahora!);
          DateTime _datahora = DateTime(
            datahora.year,
            datahora.month,
            datahora.day,
          );
          int passeioId = passeio.id!;

          if (selectedEvents[_datahora] != null) {
            selectedEvents[_datahora]!.add(
              Event(
                titulo: titulo,
                subtitulo: subtitulo,
                datahora: formatarData(datahora.toString()),
                passeioId: passeioId,
              ),
            );
          } else {
            selectedEvents[_datahora] = [
              Event(
                titulo: titulo,
                subtitulo: subtitulo,
                datahora: formatarData(datahora.toString()),
                passeioId: passeioId,
              ),
            ];
          }
        },
      );
      state.value = StateEnum.success;
    } catch (e) {
      state.value = StateEnum.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(64),
        child: TitlePageWidget(
          title: "Minha agenda",
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: state,
                builder: (_, value, __) {
                  StateEnum currentState = value as StateEnum;

                  if (currentState == StateEnum.loading) {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return TableCalendar(
                      locale: 'pt_BR',
                      firstDay: DateTime(1990),
                      lastDay: DateTime(2050),
                      focusedDay: selectedDay,
                      calendarFormat: calendarFormat,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      daysOfWeekVisible: true,
                      onFormatChanged: (CalendarFormat _format) {
                        setState(() {
                          calendarFormat = _format;
                        });
                      },
                      onDaySelected: (DateTime selectDay, DateTime focusDay) {
                        setState(() {
                          selectedDay = selectDay;
                          focusedDay = focusDay;
                        });

                        DateTime datahora = DateTime(
                          selectDay.year,
                          selectDay.month,
                          selectDay.day,
                        );

                        if (selectedEvents[datahora] != null) {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                child: ListView.builder(
                                  itemCount: selectedEvents[datahora]!.length,
                                  itemBuilder: (context, index) {
                                    List<Event>? list =
                                        selectedEvents[datahora];
                                    if (list != null) {
                                      return ListTile(
                                        trailing: Text(list[index].datahora),
                                        title: Text(list[index].titulo),
                                        subtitle: Text(list[index].subtitulo),
                                      );
                                    } else {
                                      return Container(
                                        child: Text(
                                          "Não há passeio para esta data.",
                                        ),
                                      );
                                    }
                                  },
                                ),
                              );
                            },
                          );
                        }
                      },
                      selectedDayPredicate: (DateTime date) {
                        return isSameDay(selectedDay, date);
                      },
                      eventLoader: _getEventsFromDay,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
