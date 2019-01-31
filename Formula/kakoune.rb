class Kakoune < Formula
  desc "Selection-based modal text editor"
  homepage "https://github.com/mawww/kakoune"
  url "https://github.com/mawww/kakoune/releases/download/v2019.01.20/kakoune-2019.01.20.tar.bz2"
  sha256 "991103a227be00ca1b10ad575fd6c749fa4c99eb19763971c7b1e113e299b995"

  bottle do
    cellar :any
    sha256 "e48ab23c42154ca9ca49590973ddb9a42ee56e03e90a3638179f7b93fdb354d9" => :mojave
    sha256 "76fa91e8b4a1a3fc8ae0021d1837c0d737b60e6b6bbe9b5f0553699c4c20a2ba" => :high_sierra
    sha256 "339e3637cc002372ef7a4a3a25aa7e88a8316b6bb0a269c380a60cf7a16c05ec" => :sierra
  end

  depends_on "asciidoc" => :build
  depends_on "docbook-xsl" => :build
  depends_on "ncurses"

  if MacOS.version <= :el_capitan
    depends_on "gcc"
    fails_with :clang do
      build 800
      cause "New C++ features"
    end
  end

  def install
    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"

    cd "src" do
      system "make", "install", "debug=no", "PREFIX=#{prefix}"
    end
  end

  test do
    system bin/"kak", "-ui", "dummy", "-e", "q"
  end
end
