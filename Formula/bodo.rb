# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1114.4729/bodo-darwin-arm64"
  version "2026.1114.4729"
  sha256 "b3c97ecbe80d16f29bd3023f556d1a816e7ab7180448ded9b544cefc1012d514"
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
      url "https://cli.bodo-app.com/v/2026.1114.4729/bodo-linux-arm64"
      sha256 "8aa6e3fd2f6de757947d59c77804b498bebb1fdc738bf420e7fc5edd070c2a06"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1114.4729/bodo-linux-x64"
      sha256 "0512a8396639ba68d5fc125484755718b5456ed1692e8752cfc4ce8de3ec1882"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
