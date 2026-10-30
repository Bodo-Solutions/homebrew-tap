# Formula/bodo-rc.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-kanaele.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/rc/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class BodoRc < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1030.4666-rc/bodo-darwin-arm64"
  version "2026.1030.4666-rc"
  sha256 "fb36289b973f826501ffaf89823ede6556ac8a08a3a29e29d85826f6a9728bcd"
  license :cannot_represent

  livecheck do
    url "https://cli.bodo-app.com/rc/manifest.json"
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
      url "https://cli.bodo-app.com/v/2026.1030.4666-rc/bodo-linux-arm64"
      sha256 "7d3abd356b689d42a6b097edb176939cff4255d018ed4dffa80e6949fdf61fa3"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1030.4666-rc/bodo-linux-x64"
      sha256 "102e55ea60752fc66d8c2fd64c65762dd5a3a131765f2586989b89980a4066c4"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
