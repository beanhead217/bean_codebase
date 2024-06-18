// import '../entity_component/entity.dart';
//
// mixin VisibleComponent on Entity {
//   bool isVisible = false;
//
//   @override
//   void update(double dt) {
//     super.update(dt);
//     _checkVisibility();
//   }
//
//   void _checkVisibility() {
//     final camera = gameRef.camera;
//     final visibleRect = camera.visibleWorldRect.inflate(100); // Inflating the rect to include a margin
//
//     if (visibleRect.overlaps(toRect())) {
//       if (!isVisible) {
//         onVisible();
//         isVisible = true;
//       }
//     } else {
//       if (isVisible) {
//         onInvisible();
//         isVisible = false;
//       }
//     }
//   }
//
//   void onVisible() {
//     // Implement actions when the component becomes visible
//   }
//
//   void onInvisible() {
//     // Implement actions when the component becomes invisible
//   }
// }
