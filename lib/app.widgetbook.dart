// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// WidgetbookGenerator
// **************************************************************************

import 'package:budget_together/theme/custom_theme.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:budget_together/core/atoms/buttons/month_toggle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:budget_together/core/widget_book/widget_book_multi_center.dart';
import 'package:flutter/foundation.dart';
import 'package:budget_together/core/atoms/buttons/year_toggle.dart';
import 'package:budget_together/core/atoms/form_elements/custom_dropdown.dart';
import 'package:budget_together/core/atoms/form_elements/custom_form_input.dart';
import 'package:flutter/services.dart';
import 'package:budget_together/core/atoms/form_elements/custom_radio_button.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(HotReload());
}

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      appInfo: AppInfo(
        name: 'Example App',
      ),
      lightTheme: lightTheme(context),
      devices: [
        Device(
          name: 'iPhone 12',
          resolution: Resolution(
            nativeSize: DeviceSize(
              height: 2532.0,
              width: 1170.0,
            ),
            scaleFactor: 3.0,
          ),
          type: DeviceType.mobile,
        ),
      ],
      categories: [
        WidgetbookCategory(
          name: 'use cases',
          folders: [
            WidgetbookFolder(
              name: 'core',
              widgets: [],
              folders: [
                WidgetbookFolder(
                  name: 'atoms',
                  widgets: [],
                  folders: [
                    WidgetbookFolder(
                      name: 'form_elements',
                      widgets: [
                        WidgetbookWidget(
                          name: 'CustomRadioButton',
                          useCases: [
                            WidgetbookUseCase(
                              name: 'active',
                              builder: (context) => widgetBookCustomRadioButton(context),
                            ),
                            WidgetbookUseCase(
                              name: 'not active',
                              builder: (context) => widgetBookCustomRadioButton2(context),
                            ),
                          ],
                        ),
                        WidgetbookWidget(
                          name: 'CustomDropdownButton<dynamic>',
                          useCases: [
                            WidgetbookUseCase(
                              name: 'default',
                              builder: (context) => widgetBookCustomDropdownButton(context),
                            ),
                          ],
                        ),
                        WidgetbookWidget(
                          name: 'CustomFormField',
                          useCases: [
                            WidgetbookUseCase(
                              name: 'default',
                              builder: (context) => widgetBookCustomFormField(context),
                            ),
                          ],
                        ),
                      ],
                      folders: [],
                    ),
                    WidgetbookFolder(
                      name: 'buttons',
                      widgets: [
                        WidgetbookWidget(
                          name: 'YearToggle',
                          useCases: [
                            WidgetbookUseCase(
                              name: 'active',
                              builder: (context) => widgetBookYearToggle(context),
                            ),
                            WidgetbookUseCase(
                              name: 'not active',
                              builder: (context) => widgetBookYearToggle2(context),
                            ),
                          ],
                        ),
                        WidgetbookWidget(
                          name: 'MonthToggle',
                          useCases: [
                            WidgetbookUseCase(
                              name: 'active',
                              builder: (context) => widgetBookMonthToggle(context),
                            ),
                            WidgetbookUseCase(
                              name: 'not active',
                              builder: (context) => widgetBookMonthToggle2(context),
                            ),
                          ],
                        ),
                      ],
                      folders: [],
                    ),
                  ],
                ),
              ],
            ),
          ],
          widgets: [],
        ),
      ],
    );
  }
}
