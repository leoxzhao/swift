// RUN: %target-resilience-test
// REQUIRES: executable_test

// Use swift-version 4.
// UNSUPPORTED: swift_test_mode_optimize_none_with_implicit_dynamic

import StdlibUnittest
import struct_static_stored_to_computed


var StructStaticChangeStoredToComputedTest = TestSuite("StructStaticChangeStoredToComputed")

StructStaticChangeStoredToComputedTest.test("ChangeStoredToComputed") {
  do {
    @inline(never) func twice(_ x: inout Int) {
      x *= 2
    }

    expectEqual(ChangeStoredToComputed.value, 0)
    ChangeStoredToComputed.value = 32
    expectEqual(ChangeStoredToComputed.value, 32)
    ChangeStoredToComputed.value = -128
    expectEqual(ChangeStoredToComputed.value, -128)
    twice(&ChangeStoredToComputed.value)
    expectEqual(ChangeStoredToComputed.value, -256)
  }
}

runAllTests()
