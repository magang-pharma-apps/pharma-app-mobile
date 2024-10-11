import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeView extends StatelessWidget {
  const ThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Title App Bar'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.teal,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Buttons',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {},
                      child: const Text(
                        'Elevated Button',
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('Outlined Button'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Text Button'),
                    ),
                    Text(
                      "Icon Buttons",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.access_time),
                        ),
                        IconButton.filled(
                          onPressed: () {},
                          icon: const Icon(Icons.safety_check),
                        ),
                        IconButton.outlined(
                          onPressed: () {},
                          icon: const Icon(Icons.settings),
                        ),
                        IconButton.filledTonal(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.chevron_right,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey.shade400,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Text Theme',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    Text(
                      'bodySmall',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'bodyMedium',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'bodyLarge',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'labelSmall',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'labelMedium',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'labelLarge',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'titleSmall',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'titleMedium',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'titleLarge',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'headlineSmall',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'headlineMedium',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'headlineMedium',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'displaySmall',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'displayMedium',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'displayLarge',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey.shade400,
                  ),
                ),
                child: Column(
                  children: [
                    const Text('Inputs'),
                    const Divider(),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Text Field',
                        label: Text('Text Field'),
                      ),
                    ),
                    const Divider(),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Text Field',
                        label: Text('Username'),
                        prefixIcon: Icon(Icons.person),
                        suffixIcon: Icon(Icons.verified_user),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Text Field',
                        label: const Text('Text Field'),
                        prefixIcon: const Icon(Icons.person),
                        counterText: 'Counter Text',
                        counter: const Text('Counter'),
                        icon: const Icon(Icons.verified_user),
                        suffix: IconButton(
                          icon: const Icon(
                            Icons.close_outlined,
                            color: Colors.red,
                          ),
                          onPressed: () {},
                        ),
                        helperText: 'Helper Text',
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      // password
                      obscureText: true,
                      spellCheckConfiguration: SpellCheckConfiguration(
                        spellCheckService: DefaultSpellCheckService(),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        label: const Text('Password'),
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.remove_red_eye_outlined),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      textInputAction: TextInputAction.send,
                      onAppPrivateCommand: (action, data) {},
                      decoration: const InputDecoration(
                        hintText: 'Text Field',
                        label: Text('Text Field'),
                      ),
                      minLines: 1,
                      maxLines: 10,
                      scrollPhysics: const BouncingScrollPhysics(),
                    ),
                    const SizedBox(height: 15.0),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        hintText: 'Dropdown',
                        label: Text('Dropdown'),
                        prefixIcon: Icon(Icons.arrow_drop_down),
                        suffixIcon: Icon(Icons.verified_user),
                      ),
                      menuMaxHeight: 200.0,
                      items: [
                        ...List.generate(20, (index) {
                          return DropdownMenuItem<String>(
                            value: 'Item $index',
                            child: Text('Item $index'),
                          );
                        })
                      ],
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 15.0),
                    CheckboxListTile(
                      title: const Text('Checkbox'),
                      value: true,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 15.0),
                    SwitchListTile(
                      title: const Text('Switch'),
                      value: true,
                      onChanged: (value) {},
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      contentPadding: EdgeInsets.zero,
                      thumbColor: MaterialStateProperty.all(Colors.amber),
                      activeColor: Colors.amber,
                      thumbIcon: MaterialStateProperty.all(
                        const Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Switch.adaptive(
                      value: false,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 15.0),
                    RadioListTile(
                      title: const Text('Radio'),
                      value: true,
                      groupValue: true,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 15.0),
                    Slider(
                      value: 0.5,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 15.0),
                    // date picker
                    TextField(
                      readOnly: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.calendar_month),
                        hintText: 'Date Picker',
                      ),
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2025),
                        );
                      },
                    ),
                    const SizedBox(height: 15.0),
                    // time picker
                    TextField(
                      readOnly: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.timer),
                        hintText: 'Time Picker',
                      ),
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                      },
                    ),
                    const SizedBox(height: 15.0),
                    // date and time picker
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
