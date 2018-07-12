load("//:collect_data_files.bzl", "collect_data_files")

filegroup(
    name = "test_foo_data",
    srcs = [
        "foo.txt",
        "foo/foo.txt",
    ],
)

cc_test(
    name = "test_foo",
    size = "small",
    srcs = [
        "test_foo.cpp",
    ],
    data = [
        ":test_foo_data",
    ],
)

filegroup(
    name = "test_bar_data",
    srcs = [
        "bar.txt",
        "bar/bar.txt",
    ],
)

filegroup(
    name = "test_bar_lib_data",
    srcs = [
        "bar_lib.txt",
        "bar_lib/bar_lib.txt",
    ],
)

cc_library(
    name = "test_bar_lib",
    srcs = ["test_bar_lib.cpp"],
    data = [":test_bar_lib_data"],
)

cc_test(
    name = "test_bar",
    size = "small",
    srcs = [
        "test_bar.cpp",
    ],
    data = [
        ":test_bar_data",
    ],
    deps = [":test_bar_lib"],
)

collect_data_files(
    name = "collect_data",
    testonly = 1,
    deps = [
        "test_bar",
        "test_foo",
    ],
)
