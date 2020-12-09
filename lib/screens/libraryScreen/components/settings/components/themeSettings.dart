// Flutter
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';

// Internal
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';
import 'package:songtube/screens/libraryScreen/components/settings/dialogs/accentPicker.dart';
import 'package:songtube/screens/libraryScreen/components/settings/columnTile.dart';

// Packages
import 'package:provider/provider.dart';

class ThemeSettings extends StatefulWidget {
  @override
  _ThemeSettingsState createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    ConfigurationProvider config = Provider.of<ConfigurationProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return SettingsColumnTile(
      title: Languages.of(context).labelTheme,
      icon: Icons.color_lens,
      children: <Widget>[
        ListTile(
          onTap: () => config.systemThemeEnabled = !config.systemThemeEnabled,
          title: Text(
            Languages.of(context).labelUseSystemTheme,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text(Languages.of(context).labelUseSystemThemeJustification,
            style: TextStyle(fontSize: 12),),
          trailing: CircularCheckBox(
            activeColor: Theme.of(context).accentColor,
            value: config.systemThemeEnabled,
            onChanged: (bool newValue) {
              config.systemThemeEnabled = newValue;
            },
          ),
        ),
        // Enable/Disable Dark Theme
        AnimatedSize(
          vsync: this,
          curve: Curves.easeInOutBack,
          duration: Duration(milliseconds: 500),
          child: config.systemThemeEnabled == false
          ? ListTile(
              onTap: () => config.darkThemeEnabled = !config.darkThemeEnabled,
              title: Text(
                Languages.of(context).labelEnableDarkTheme,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontWeight: FontWeight.w500
                ),
              ),
              subtitle: Text(Languages.of(context).labelEnableDarkThemeJustification,
                style: TextStyle(fontSize: 12),),
              trailing: CircularCheckBox(
                activeColor: Theme.of(context).accentColor,
                value: config.darkThemeEnabled,
                onChanged: (bool newValue) {
                  config.darkThemeEnabled = newValue;
                },
              ),
            )
          : Container()
        ),
        // Enable/Disable Black Theme
        ListTile(
          onTap: () => config.blackThemeEnabled = !config.blackThemeEnabled,
          title: Text(
            Languages.of(context).labelEnableBlackTheme,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text(Languages.of(context).labelEnableBlackThemeJustification,
            style: TextStyle(fontSize: 12),),
          trailing: CircularCheckBox(
            activeColor: Theme.of(context).accentColor,
            value: config.blackThemeEnabled,
            onChanged: (bool newValue) {
              config.blackThemeEnabled = newValue;
            },
          ),
        ),
        // App AccentColor Setting
        ListTile(
          onTap: () => config.systemThemeEnabled = !config.systemThemeEnabled,
          title: Text(
            Languages.of(context).labelAccentColor,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w500
            ),
          ),
          subtitle: Text(Languages.of(context).labelAccentColorJustification,
            style: TextStyle(fontSize: 12),),
          trailing: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: IconButton(
              icon: Icon(Icons.colorize),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AccentPicker(
                      onColorChanged: (Color color) {
                        config.accentColor = color;
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
            ),
          )
        ),
        SwitchListTile(
          title: Text("Blur UI"),
          subtitle: Text("Enable/Disable Blur Style"),
          value: prefs.enableBlurUI,
          onChanged: (bool value) {
            prefs.enableBlurUI = value;
          }
        )
      ],
    );
  }
}