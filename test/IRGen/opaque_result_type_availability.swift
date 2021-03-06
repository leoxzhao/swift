// RUN: %target-swift-frontend -target x86_64-apple-macosx10.9 -Onone -emit-ir %s | %FileCheck --check-prefix=MAYBE-AVAILABLE %s
// TODO: Build with a macos deployment target that unconditionally supports opaque result types
// R/UN: %target-swift-frontend -target x86_64-apple-macosx10.9999 -Onone -emit-ir %s | %FileCheck --check-prefix=ALWAYS-AVAILABLE %s
// REQUIRES: OS=macosx

protocol P {}
extension Int: P {}

@available(macOS 9999, *)
func foo() -> some P {
  return 1738
}

@_silgen_name("external")
func generic<T: P>(x: T, y: T)

@available(macOS 9999, *)
public func main() {
  generic(x: foo(), y: foo())
}

// MAYBE-AVAILABLE: declare{{.*}} extern_weak {{.*}} @swift_getOpaqueTypeMetadata
// MAYBE-AVAILABLE: declare{{.*}} extern_weak {{.*}} @swift_getOpaqueTypeConformance
// ALWAYS-AVAILABLE-NOT: declare{{.*}} extern_weak {{.*}} @swift_getOpaqueTypeMetadata
// ALWAYS-AVAILABLE-NOT: declare{{.*}} extern_weak {{.*}} @swift_getOpaqueTypeConformance
