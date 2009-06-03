require 'rubygems'
require 'json'

dna = {
  :recipes => [
    'tsung'
  ]
}

open(File.dirname(__FILE__) + "/dna.json", "w").write(dna.to_json)
