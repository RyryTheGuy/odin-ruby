require "../basic-projects/caesar_cipher.rb"

describe "#caesar_cipher" do
  it "works with single letters" do
    expect(caesar_cipher("a", 1)).to eql("b")
  end

  it "works with words" do
    expect(caesar_cipher("Aaa", 1)).to eql("Bbb")
  end

  it "works with phrases" do
    expect(caesar_cipher("Hello, World!", 5)).to eql("Mjqqt, Btwqi!")
  end

  it "works with negative shift" do
    expect(caesar_cipher("Mjqqt, Btwqi!", -5)).to eql("Hello, World!")
  end

  it "wraps" do
    expect(caesar_cipher("Z", 1)).to eql("A")
  end

  it "works with large shift factors" do
    expect(caesar_cipher("Hello, World!", 75)).to eql("Ebiil, Tloia!")
  end

  it "works with large negative shift factors" do
    expect(caesar_cipher("Hello, World!", -29)).to eql("Ebiil, Tloia!")
  end
end