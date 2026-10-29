# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1029.4602/bodo-darwin-arm64"
  version "2026.1029.4602"
  sha256 "4abc4244d40b1931e9f2ce83de399647b85cf38bc45c461544fee649c91fd871"
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
      url "https://cli.bodo-app.com/v/2026.1029.4602/bodo-linux-arm64"
      sha256 "c079f38903ad1e99131ac8f67806907f3b7d0759ef24a6ef6d962b2b01cee174"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1029.4602/bodo-linux-x64"
      sha256 "baec98d62d32cafee4c3b73a2feba963ead313b6eb382f0a59c4a2aa1e896ea0"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
