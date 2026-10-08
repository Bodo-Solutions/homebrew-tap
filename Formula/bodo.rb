# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1008.3752/bodo-darwin-arm64"
  version "2026.1008.3752"
  sha256 "45ae324a7a7118a0569ceab88476214207d16f6952afdc0f8a3007016a7f3530"
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
      url "https://cli.bodo-app.com/v/2026.1008.3752/bodo-linux-arm64"
      sha256 "f2d83e7e1606adda81b7449cd5b32e0ccabc39255edccc11ef98772cae1686a5"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1008.3752/bodo-linux-x64"
      sha256 "dde41937abb7309484aaeff3fe416e10d44b3cafabf3ebe7cf0c4382f7e4c35c"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
