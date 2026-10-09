# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1009.3806/bodo-darwin-arm64"
  version "2026.1009.3806"
  sha256 "fb0c547c10415c478205e0205abd214662a9eb44643c1c975990e6fb1e51bb77"
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
      url "https://cli.bodo-app.com/v/2026.1009.3806/bodo-linux-arm64"
      sha256 "cc540969a10e16a306a29c45e581b0cf8b1f97d12141237de0d1a7c4c922dd1c"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1009.3806/bodo-linux-x64"
      sha256 "d324a001f9284cb5beb81dc7440de227f00b35aa24dec2220f595305025c11ec"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
