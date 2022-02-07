import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              'Your movie list is empty',
              softWrap: true,
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor),
                  fixedSize: MaterialStateProperty.all<Size>(
                    Size.fromWidth(MediaQuery.of(context).size.width * 0.8),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text('Add a new movie'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
