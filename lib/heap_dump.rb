require 'heap_dump/decoder'

module Rubinius
  module HeapDump
    def self.open(file)
      dec = Decoder.new
      dec.decode(file)
      return dec
    end
  end
end
