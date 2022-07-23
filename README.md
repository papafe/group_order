# group_order - Skunkwords Summer 2022

It's a simple application to play a little bit with Dart, Flutter and Realm together. Probably the biggest hurdle with Flutter is understanding how to work with state management. In the end I ended up using Riverpod, that seems to be the spiritual successor to what the Flutter docs recommend (Provider) and also easier to use in my opinion.

The fact that Riverpod really pushes for immutable states makes defining the state kinda awkward (at least for me), but it seems doable. I've tried different versions of the state (that I called view model to stay close to home) and it more or less works. There is a long comment in `order_page.dart` with some considerations about how the different version work and what Realm could provide to simplify the use. 
I've worked with this during skunkworks, so I could have missed some small or big details. 
