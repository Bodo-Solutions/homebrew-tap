# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1021.4191/bodo-darwin-arm64"
  version "2026.1021.4191"
  sha256 "c7ae181de3e169b43b9a315746adff79a6a71d7ec5a859bad2ced4ff96ac6d85"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/stable/manifest.json"
    regex(/^v?(\d+(?:\.\d+)+(?:-rc)?)$/i)
    strategy :json do |json, regex|
      json["version"]&.[](regex, 1)
    end
  end

  on_macos do
    depends_on arch: :arm64 unless Hardware::CPU.in_rosetta2?
  end

  on_linux do
    on_arm do
      url "https://cli.bodo-app.com/v/2026.1021.4191/bodo-linux-arm64"
      sha256 "7812bae6e9c5d53e5888509fdefaba30e06dde94c6db4a5add45e2b419e764f9"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1021.4191/bodo-linux-x64"
      sha256 "7ad0955a30fbd95822765336aa4232fcf0addb464d77213b2415865c933723ed"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
