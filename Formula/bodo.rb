# Formula/bodo.rb — erzeugt aus dem Kanal-Manifest, nicht von Hand ändern.
#
# Quelle: scripts/cli-channels.ts (Verb `rendern`). Fassung und jede Prüfsumme stammen aus
# https://cli.bodo-app.com/stable/manifest.json — eine Wahrheitsquelle für alle Kanäle.
class Bodo < Formula
  desc "Kommandozeile der Bodo-Unternehmensplattform"
  homepage "https://cli.bodo-app.com"
  url "https://cli.bodo-app.com/v/2026.1117.4746/bodo-darwin-arm64"
  version "2026.1117.4746"
  sha256 "ad704aad6645eaa4fd89fbd98ab7cc4adcf9863552e59e3503284a175fc5fb7a"
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
      url "https://cli.bodo-app.com/v/2026.1117.4746/bodo-linux-arm64"
      sha256 "8fd28065643e3a075f49dc5a8f2b4b626a01a9abbb675c2b37c20bd2c8315c36"
    end
    on_intel do
      url "https://cli.bodo-app.com/v/2026.1117.4746/bodo-linux-x64"
      sha256 "e22463ffef98b64215e1b819c46f3caedf5148dd20932adf4d11c44238161599"
    end
  end

  def install
    bin.install Dir["bodo-*"].first => "bodo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bodo version")
  end
end
