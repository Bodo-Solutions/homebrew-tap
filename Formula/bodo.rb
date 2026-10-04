# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1004.3611/bodo-darwin-arm64"
  version "2026.1004.3611"
  sha256 "800991a0649070788be6d6e3c6ff02a619a4487676322da77677a4b7e1f89196"
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
      url "https://cli.bodo-app.com/v/2026.1004.3611/bodo-linux-arm64"
      sha256 "a050d2a314ca0c574cd67f6d63e4ce48d4ba43b8e8f1c35ecde59a0a9e4984aa"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1004.3611/bodo-linux-x64"
      sha256 "0bcb1dd1d1eda6a3c787248bed104447d743f2a5345bee0c79eafc086cea233c"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
