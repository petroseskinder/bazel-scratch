# Aspect to collect the data files on targets using transitive `deps`
DataFilesInfo = provider(
    fields = {
        "data_files": "Data files for this target",
    },
)

def _collect_data_aspect_impl(target, ctx):
    data_files = []
    if hasattr(ctx.rule.attr, "data"):
        for src in ctx.rule.attr.data:
            for f in src.files:
                data_files += [f]
    for dep in ctx.rule.attr.deps:
        data_files += dep[DataFilesInfo].data_files
    return [DataFilesInfo(data_files = data_files)]

collect_data_aspect = aspect(
    attr_aspects = [
        "deps",
    ],
    implementation = _collect_data_aspect_impl,
)

# rule to write list of target labels and their data files into a file
def _collect_data_rule_impl(ctx):
    data_files_string = ""
    for dep in ctx.attr.deps:
        data_files = [f.path for f in dep[DataFilesInfo].data_files]
        data_files_string += str(dep.label) + ","
        data_files_string += ",".join(data_files) + "\n"
    ctx.actions.write(ctx.outputs.data_files, data_files_string)

collect_data_files = rule(
    attrs = {
        "deps": attr.label_list(aspects = [collect_data_aspect]),
    },
    outputs = {
        "data_files": "%{name}_data_files.txt",
    },
    implementation = _collect_data_rule_impl,
)
