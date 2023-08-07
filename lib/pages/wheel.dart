import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:qualrole/main.dart';
import 'package:qualrole/pages/pages.dart';
import 'package:qualrole/router.dart';

import '../common/common.dart';
import '../widgets/widgets.dart';

class FortuneWheelPage extends HookWidget {
  static const kRouteName = 'FortuneWheelPage';

  static void go(BuildContext context) {
    context.goNamed(kRouteName);
  }

  @override
  Widget build(BuildContext context) {
    final alignment = useState(Alignment.topCenter);
    final selected = useStreamController<int>();
    final selectedIndex = useStream(selected.stream, initialData: 0).data ?? 0;
    final isAnimating = useState(false);

    void handleRoll() {
      selected.add(
        roll(Values.fortuneValues.length),
      );
    }

    return AppLayout(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 8),
            RollButtonWithPreview(
              selected: selectedIndex,
              items: Values.fortuneValues,
              onPressed: isAnimating.value ? null : handleRoll,
            ),
            SizedBox(height: 8),
            Expanded(
              child: FortuneWheel(
                alignment: alignment.value,
                selected: selected.stream,
                onAnimationStart: () => isAnimating.value = true,
                onAnimationEnd: () => isAnimating.value = false,
                onFling: handleRoll,
                hapticImpact: HapticImpact.heavy,
                indicators: [
                  FortuneIndicator(
                    alignment: alignment.value,
                    child: TriangleIndicator(),
                  ),
                ],
                items: [
                  for (var it in Values.fortuneValues)
                    FortuneItem(child: Text(it), onTap: () => print(it))
                ],
              ),
            ),
            FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ListRoute()));
              },
              label: const Text('Nova Lista'),
              icon: const Icon(Icons.add),
              backgroundColor: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}

class ListRoute extends StatelessWidget {
  const ListRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Lista'),
      ),
      body: ListView.builder(
          itemCount: Values.fortuneValues.length,
          prototypeItem: ListTile(
            title: Text(Values.fortuneValues.first),
          ),
          itemBuilder: (context, index) {
            return ListTile(title: Text(Values.fortuneValues[index]));
          }),
    );
  }
}
