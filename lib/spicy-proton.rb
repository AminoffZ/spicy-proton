require 'forwardable'
require 'disk-corpus'
require 'memory-corpus'

module Spicy
  class Proton
    extend Forwardable
    
    def initialize(seed = nil)
      @corpus = Memory::Corpus.new(seed)
    end
    
    class << self
      [:adjective, :noun, :adverb, :verb, :pair, :format].each do |method|
        define_method(method) do |*args, &block|
          Disk::Corpus.use do |c|
            c.send(method, *args, &block)
          end
        end
      end
    end
    def_delegators :@corpus, :adjective, :noun, :adverb, :verb, :adjectives, :nouns, :adverbs, :verbs, :pair, :format
  end
end
