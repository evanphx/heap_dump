require 'heap_dump'
require 'heap_dump/diff'

file = ARGV.shift
after_file = ARGV.shift

if after_file
  before = Rubinius::HeapDump.open(file)
  after =  Rubinius::HeapDump.open(after_file)

  diff = Rubinius::HeapDump::Diff.new(before, after)

  histo = diff.histogram

  histo.each_sorted do |name, entry|
    printf "%10d %30s %d\n", entry.objects, name, entry.bytes
  end
else
  decoder = Rubinius::HeapDump.open(file)

  histo = decoder.all_objects.histogram

  histo.each_sorted do |klass, entry|
    printf "%10d %30s %d\n", entry.objects, klass.name, entry.bytes
  end
end
