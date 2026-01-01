require "./spec_helper"

describe CrystalCtags do
  it "create CTAGS for src/crystal_ctags.cr" do
    str = String::Builder.build do |io|
      CrystalCtags::Ctags.new(["src/crystal_ctags.cr"]).to_s(io)
    end

    lines = str.lines
    lines[0].should eq "!_TAG_FILE_FORMAT\t2\t/extended format; --format=1 will not append ;\" to lines/"
    lines[1].should eq "!_TAG_FILE_SORTED\t1\t/0=unsorted, 1=sorted, 2=foldcase/"
    lines[4..].should eq ["CrystalCtags\tsrc/crystal_ctags.cr\t/^module CrystalCtags$/;\"\tm\tline:5",
                          "Ctags\tsrc/crystal_ctags.cr\t/^  class Ctags$/;\"\tc\tline:160\tnamespace:CrystalCtags",
                          "CtagsVisitor\tsrc/crystal_ctags.cr\t/^  class CtagsVisitor < Crystal::Visitor$/;\"\tc\tline:37\tnamespace:CrystalCtags",
                          "Tag\tsrc/crystal_ctags.cr\t/^  class Tag$/;\"\tc\tline:16\tnamespace:CrystalCtags",
                          "end_visit\tsrc/crystal_ctags.cr\t/^    def end_visit(node : Crystal::ClassDef | Crystal::ModuleDef | Crystal::CStructOrUnionDef | Crystal::LibDef)$/;\"\td\tline:109\tnamespace:CrystalCtags.CtagsVisitor\tsignature:(node : Crystal::ClassDef | Crystal::ModuleDef | Crystal::CStructOrUnionDef | Crystal::LibDef)",
                          "initialize\tsrc/crystal_ctags.cr\t/^    def initialize(@name, @filename, @regex, @kind, @line = nil, @scope = nil, @signature = nil, @type = nil)$/;\"\td\tline:25\tnamespace:CrystalCtags.Tag\tsignature:(name, filename, regex, kind, line = nil, scope = nil, signature = nil, type = nil)",
                          "initialize\tsrc/crystal_ctags.cr\t/^    def initialize(@filename, @content)$/;\"\td\tline:52\tnamespace:CrystalCtags.CtagsVisitor\tsignature:(filename, content)",
                          "initialize\tsrc/crystal_ctags.cr\t/^    def initialize(filenames)$/;\"\td\tline:163\tnamespace:CrystalCtags.Ctags\tsignature:(filenames)",
                          "process_node\tsrc/crystal_ctags.cr\t/^    def process_node(node, name : String, kind : Symbol, signature : String | Nil = nil)$/;\"\td\tline:114\tnamespace:CrystalCtags.CtagsVisitor\tsignature:(node, name : String, kind : Symbol, signature : String | Nil = nil)",
                          "regexpize\tsrc/crystal_ctags.cr\t/^    def regexpize(str : String)$/;\"\td\tline:153\tnamespace:CrystalCtags.CtagsVisitor\tsignature:(str : String)",
                          "relativize\tsrc/crystal_ctags.cr\t/^    def relativize(filename)$/;\"\td\tline:131\tnamespace:CrystalCtags.CtagsVisitor\tsignature:(filename)",
                          "to_s\tsrc/crystal_ctags.cr\t/^    def to_s(io)$/;\"\td\tline:28\tnamespace:CrystalCtags.Tag\tsignature:(io)",
                          "to_s\tsrc/crystal_ctags.cr\t/^    def to_s(io)$/;\"\td\tline:178\tnamespace:CrystalCtags.Ctags\tsignature:(io)",
                          "visit\tsrc/crystal_ctags.cr\t/^    def visit(node : Crystal::ClassDef)$/;\"\td\tline:57\tnamespace:CrystalCtags.CtagsVisitor\tsignature:(node : Crystal::ClassDef)",
                          "visit\tsrc/crystal_ctags.cr\t/^    def visit(node : Crystal::ModuleDef)$/;\"\td\tline:63\tnamespace:CrystalCtags.CtagsVisitor\tsignature:(node : Crystal::ModuleDef)",
                          "visit\tsrc/crystal_ctags.cr\t/^    def visit(node : Crystal::Def)$/;\"\td\tline:69\tnamespace:CrystalCtags.CtagsVisitor\tsignature:(node : Crystal::Def)",
                          "visit\tsrc/crystal_ctags.cr\t/^    def visit(node : Crystal::Macro)$/;\"\td\tline:79\tnamespace:CrystalCtags.CtagsVisitor\tsignature:(node : Crystal::Macro)",
                          "visit\tsrc/crystal_ctags.cr\t/^    def visit(node : Crystal::LibDef)$/;\"\td\tline:84\tnamespace:CrystalCtags.CtagsVisitor\tsignature:(node : Crystal::LibDef)",
                          "visit\tsrc/crystal_ctags.cr\t/^    def visit(node : Crystal::StructOrUnionDef)$/;\"\td\tline:90\tnamespace:CrystalCtags.CtagsVisitor\tsignature:(node : Crystal::StructOrUnionDef)",
                          "visit\tsrc/crystal_ctags.cr\t/^    def visit(node : Crystal::FunDef)$/;\"\td\tline:96\tnamespace:CrystalCtags.CtagsVisitor\tsignature:(node : Crystal::FunDef)",
                          "visit\tsrc/crystal_ctags.cr\t/^    def visit(node : Crystal::Expressions)$/;\"\td\tline:101\tnamespace:CrystalCtags.CtagsVisitor\tsignature:(node : Crystal::Expressions)",
                          "visit\tsrc/crystal_ctags.cr\t/^    def visit(node : Crystal::ASTNode)$/;\"\td\tline:105\tnamespace:CrystalCtags.CtagsVisitor\tsignature:(node : Crystal::ASTNode)"]
  end
end
